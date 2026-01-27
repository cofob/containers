#!/bin/bash
docker build -t cofob/nmd .
docker tag cofob/nmd ghcr.io/cofob/nmd
#docker push cofob/nmd
docker push ghcr.io/cofob/nmd
