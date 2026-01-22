Based on https://github.com/Arairon/slskd-stats

```yaml
services:
  slskd-exporter:
    image: ghcr.io/cofob/slskd-exporter
    ports:
      - "8000:8000"
    volumes:
      - slskd_data:/data
    command: --db /data/data/transfers.db
    restart: always
```
