#!/bin/bash
docker build -t cofob/slskd-exporter .
docker tag cofob/slskd-exporter ghcr.io/cofob/slskd-exporter
docker push cofob/slskd-exporter
docker push ghcr.io/cofob/slskd-exporter
