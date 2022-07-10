#!/bin/bash
docker build -t cofob/caddy .
docker tag cofob/caddy ghcr.io/cofob/caddy
docker push cofob/caddy
docker push ghcr.io/cofob/caddy

cd proxy/
docker build -t cofob/caddy:proxy .
docker tag cofob/caddy:proxy ghcr.io/cofob/caddy:proxy
docker push cofob/caddy:proxy
docker push ghcr.io/cofob/caddy:proxy
cd ..
