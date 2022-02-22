#!/bin/bash
docker build -t cofob/caddy .
docker tag cofob/caddy ghcr.io/cofob/caddy
docker push cofob/caddy
docker push ghcr.io/cofob/caddy