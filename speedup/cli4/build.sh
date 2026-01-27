#!/bin/bash
docker build -t cofob/cli4 .
docker tag cofob/cli4 ghcr.io/cofob/cli4
#docker push cofob/cli4
docker push ghcr.io/cofob/cli4
