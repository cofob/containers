#!/usr/bin/env python3
"""
slskd Prometheus exporter (standard-library only)

Behavior:
- Opens the SQLite DB fresh on every /metrics request, reads Transfers, then closes.
- Exposes Prometheus text format at /metrics.

Exports:
- slskd_transfer_bytes_total{direction="upload|download"} (successful completed transfers)
- slskd_transfer_completed_total{direction="..."} (count of successful completed transfers)
- slskd_transfer_failed_total{direction="..."} (count of completed but not succeeded)
- slskd_transfer_average_speed_bytes_per_second{direction="..."} (avg over successful completed transfers)
- slskd_transfer_user_bytes_total{direction="...",user="..."} (per user bytes, successful+completed)
- slskd_transfer_error_total{direction="...",error="..."} (failed counts by error category)
- Exporter self-metrics: scrape duration, success, last scrape timestamp
"""

from __future__ import annotations

import argparse
import sqlite3
import time
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from typing import Dict, Iterable, List, Tuple, Union


STATE_FLAGS = [
    "None",
    "Requested",
    "Queued",
    "Initializing",
    "InProgress",
    "Completed",
    "Succeeded",
    "Cancelled",
    "TimedOut",
    "Errored",
    "Rejected",
    "Aborted",
    "Locally",
    "Remotely",
]


def parse_state_bitmask(state: int) -> List[str]:
    flags: List[str] = []
    if state == 0:
        return [STATE_FLAGS[0]]
    offset = 0
    while state > 0:
        if state & 1:
            flags.append(STATE_FLAGS[offset + 1])
        offset += 1
        state >>= 1
    return flags


def parse_state_old(state: str) -> List[str]:
    flags: List[str] = []
    parts = state.split(", ")
    for f in STATE_FLAGS:
        if f in parts:
            flags.append(f)
    return flags


def escape_label_value(v: str) -> str:
    return v.replace("\\", "\\\\").replace("\n", "\\n").replace('"', '\\"')


def metric_line(
    name: str, value: Union[int, float], labels: Dict[str, str] | None = None
) -> str:
    if labels:
        lbl = ",".join(f'{k}="{escape_label_value(str(v))}"' for k, v in labels.items())
        return f"{name}{{{lbl}}} {value}\n"
    return f"{name} {value}\n"


def help_and_type(help_text: str, metric_name: str, metric_type: str) -> str:
    return f"# HELP {metric_name} {help_text}\n# TYPE {metric_name} {metric_type}\n"


def is_valid_transfers_db(conn: sqlite3.Connection) -> bool:
    cur = conn.cursor()
    try:
        cur.execute(
            "SELECT name FROM sqlite_master WHERE type='table' AND name='Transfers' LIMIT 1;"
        )
        return bool(cur.fetchall())
    except sqlite3.DatabaseError:
        return False
    finally:
        cur.close()


def fetch_transfers(
    conn: sqlite3.Connection,
) -> List[Tuple[str, str, int, Union[int, str], float, str]]:
    cur = conn.cursor()
    try:
        cur.execute(
            "SELECT Username, Direction, Size, State, AverageSpeed, Exception FROM Transfers;"
        )
        return cur.fetchall()
    finally:
        cur.close()


def shorten_error(error: str) -> str:
    parts = (error or "").split(" ")
    short_err = " ".join(parts[:4]).strip(" .")
    if "appears to" in short_err:
        return "User offline"
    return short_err or "Unknown error"


def compute_stats(
    transfers: Iterable[Tuple[str, str, int, Union[int, str], float, str]],
):
    stats = {
        "old_db_format": 0,
        "upload": {
            "bytes": 0,
            "completed": 0,  # successful+completed files
            "failed": 0,  # completed but not succeeded
            "speed_sum": 0.0,  # sum avg speeds for successful+completed
            "users": {},  # user -> bytes
            "errors": {},  # error -> count
        },
        "download": {
            "bytes": 0,
            "completed": 0,
            "failed": 0,
            "speed_sum": 0.0,
            "users": {},
            "errors": {},
        },
    }

    transfers_list = list(transfers)
    if not transfers_list:
        return stats

    if isinstance(transfers_list[0][3], str):
        stats["old_db_format"] = 1

    for username, direction, size, state, avg_speed, error in transfers_list:
        if isinstance(state, str):
            flags = parse_state_old(state)
        else:
            flags = parse_state_bitmask(int(state))

        if "Completed" not in flags:
            continue

        succeeded = "Succeeded" in flags
        bucket = stats["upload"] if direction == "Upload" else stats["download"]

        if succeeded:
            bucket["bytes"] += int(size)
            bucket["completed"] += 1
            bucket["speed_sum"] += float(avg_speed or 0.0)
            bucket["users"][username] = bucket["users"].get(username, 0) + int(size)
        else:
            bucket["failed"] += 1
            se = shorten_error(error)
            bucket["errors"][se] = bucket["errors"].get(se, 0) + 1

    return stats


def scrape_db_and_build_metrics(db_path: Path) -> Tuple[str, int]:
    """
    Opens DB, scrapes Transfers, closes DB, then returns (metrics_text, success_flag).
    """
    start = time.time()
    success = 1
    out: List[str] = []

    # Self-metrics headers
    out.append(
        help_and_type(
            "Time spent scraping the slskd database.",
            "slskd_exporter_scrape_duration_seconds",
            "gauge",
        )
    )
    out.append(
        help_and_type(
            "Whether the last scrape succeeded (1) or failed (0).",
            "slskd_exporter_scrape_success",
            "gauge",
        )
    )
    out.append(
        help_and_type(
            "Unix timestamp of the last scrape.",
            "slskd_exporter_last_scrape_timestamp_seconds",
            "gauge",
        )
    )

    try:
        if not db_path.exists() or not db_path.is_file():
            raise FileNotFoundError(
                f"DB path does not exist or is not a file: {db_path}"
            )

        # Open fresh connection per scrape
        conn = sqlite3.connect(str(db_path), timeout=5)
        try:
            if not is_valid_transfers_db(conn):
                raise ValueError(
                    "SQLite database is missing Transfers table or is invalid."
                )
            transfers = fetch_transfers(conn)
        finally:
            # Always close connection after each scrape
            conn.close()

        stats = compute_stats(transfers)

        # Metric headers
        out.append(
            help_and_type(
                "1 if slskd transfers DB is in old format (State stored as TEXT).",
                "slskd_transfers_db_old_format",
                "gauge",
            )
        )
        out.append(
            help_and_type(
                "Total bytes transferred for successful completed transfers.",
                "slskd_transfer_bytes_total",
                "counter",
            )
        )
        out.append(
            help_and_type(
                "Total number of successful completed transfers (files).",
                "slskd_transfer_completed_total",
                "counter",
            )
        )
        out.append(
            help_and_type(
                "Total number of failed completed transfers (completed but not succeeded).",
                "slskd_transfer_failed_total",
                "counter",
            )
        )
        out.append(
            help_and_type(
                "Average speed in bytes/second for successful completed transfers.",
                "slskd_transfer_average_speed_bytes_per_second",
                "gauge",
            )
        )
        out.append(
            help_and_type(
                "Bytes transferred per user for successful completed transfers.",
                "slskd_transfer_user_bytes_total",
                "counter",
            )
        )
        out.append(
            help_and_type(
                "Count of failed completed transfers by error category.",
                "slskd_transfer_error_total",
                "counter",
            )
        )

        # Values
        out.append(metric_line("slskd_transfers_db_old_format", stats["old_db_format"]))

        for direction_key, direction_label in (
            ("upload", "upload"),
            ("download", "download"),
        ):
            d = stats[direction_key]
            out.append(
                metric_line(
                    "slskd_transfer_bytes_total",
                    int(d["bytes"]),
                    {"direction": direction_label},
                )
            )
            out.append(
                metric_line(
                    "slskd_transfer_completed_total",
                    int(d["completed"]),
                    {"direction": direction_label},
                )
            )
            out.append(
                metric_line(
                    "slskd_transfer_failed_total",
                    int(d["failed"]),
                    {"direction": direction_label},
                )
            )
            avg = 0.0
            if d["completed"] > 0 and d["speed_sum"] > 0:
                avg = float(d["speed_sum"]) / float(d["completed"])
            out.append(
                metric_line(
                    "slskd_transfer_average_speed_bytes_per_second",
                    float(avg),
                    {"direction": direction_label},
                )
            )

            for user, b in d["users"].items():
                out.append(
                    metric_line(
                        "slskd_transfer_user_bytes_total",
                        int(b),
                        {"direction": direction_label, "user": user},
                    )
                )

            for err, c in d["errors"].items():
                out.append(
                    metric_line(
                        "slskd_transfer_error_total",
                        int(c),
                        {"direction": direction_label, "error": err},
                    )
                )

    except Exception:
        success = 0

    duration = time.time() - start
    out.append(metric_line("slskd_exporter_scrape_duration_seconds", float(duration)))
    out.append(metric_line("slskd_exporter_scrape_success", int(success)))
    out.append(
        metric_line("slskd_exporter_last_scrape_timestamp_seconds", float(time.time()))
    )

    return "".join(out), success


class MetricsHandler(BaseHTTPRequestHandler):
    DB_PATH: Path = Path("./transfers.db")

    def do_GET(self):  # noqa: N802
        if self.path not in ("/metrics", "/metrics/"):
            self.send_response(404)
            self.send_header("Content-Type", "text/plain; charset=utf-8")
            self.end_headers()
            self.wfile.write(b"Not Found\n")
            return

        body, ok = scrape_db_and_build_metrics(self.DB_PATH)
        self.send_response(200 if ok else 500)
        self.send_header("Content-Type", "text/plain; version=0.0.4; charset=utf-8")
        self.send_header("Cache-Control", "no-store")
        self.end_headers()
        self.wfile.write(body.encode("utf-8"))

    def log_message(self, fmt: str, *args):
        return


def main():
    p = argparse.ArgumentParser(
        prog="slskd-prom-exporter",
        description="Prometheus exporter for slskd transfers.db",
    )
    p.add_argument(
        "--db", default="./transfers.db", help="Path to transfers.db (SQLite)"
    )
    p.add_argument("--listen", default="0.0.0.0", help="Listen address")
    p.add_argument("--port", type=int, default=8000, help="Listen port")
    args = p.parse_args()

    MetricsHandler.DB_PATH = Path(args.db).expanduser().resolve()

    httpd = ThreadingHTTPServer((args.listen, args.port), MetricsHandler)
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        pass
    finally:
        httpd.server_close()


if __name__ == "__main__":
    main()
