#!/bin/bash
docker build -t cofob/ts-derpprobe .
docker tag cofob/ts-derpprobe ghcr.io/cofob/ts-derpprobe
docker push cofob/ts-derpprobe
docker push ghcr.io/cofob/ts-derpprobe