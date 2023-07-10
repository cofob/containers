FROM rust:1-slim-bookworm as builder

ENV RUST_BACKTRACE=1

RUN apt-get update
RUN apt-get install -y \
	git pkg-config libssl-dev libjemalloc-dev make clang liburing-dev
RUN git clone --recurse-submodules https://github.com/lichess-org/lila-openingexplorer.git /lila-openingexplorer

WORKDIR /lila-openingexplorer

RUN cargo build --release


FROM debian:bookworm-slim

ENV BIND=0.0.0.0:9002 LILA=https://lichess.org
EXPOSE 9002

RUN apt-get update && apt-get install -y \
	ca-certificates liburing2 \
	&& rm -rf /var/lib/apt/lists/*

COPY --from=builder /lila-openingexplorer/target/release/lila-openingexplorer /bin/lila-openingexplorer

CMD lila-openingexplorer --bind $BIND --lila $LILA
