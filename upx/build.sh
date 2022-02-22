#!/bin/bash
docker build -t cofob/upx .
docker tag cofob/upx ghcr.io/cofob/upx
docker push cofob/upx
docker push ghcr.io/cofob/upx
