#!/bin/bash
cp -r ../scripts/* .
docker build -t cofob/minecraft:17 .
docker tag cofob/minecraft:17 ghcr.io/cofob/minecraft:17
#docker push cofob/minecraft:17
docker push ghcr.io/cofob/minecraft:17