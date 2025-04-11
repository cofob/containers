#!/bin/bash
git clone https://github.com/boringproxy/boringproxy
cd boringproxy

apt-get install inkscape -y

docker build -t cofob/boringproxy .
docker tag cofob/boringproxy ghcr.io/cofob/boringproxy
docker push cofob/boringproxy
docker push ghcr.io/cofob/boringproxy
