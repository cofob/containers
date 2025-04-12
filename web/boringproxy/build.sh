#!/bin/bash
git clone https://github.com/cofob/boringproxy
cd boringproxy

sudo apt-get update
sudo apt-get install inkscape -y

docker build -t cofob/boringproxy .
docker tag cofob/boringproxy ghcr.io/cofob/boringproxy
docker push cofob/boringproxy
docker push ghcr.io/cofob/boringproxy
