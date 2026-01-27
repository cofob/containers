#!/bin/bash
git clone https://github.com/cofob/boringproxy
cd boringproxy

docker build -t cofob/boringproxy .
docker tag cofob/boringproxy ghcr.io/cofob/boringproxy
#docker push cofob/boringproxy
docker push ghcr.io/cofob/boringproxy
