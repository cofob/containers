#!/bin/bash
cp -r ../scripts/* .
docker build -t cofob/minecraft:19 .
docker tag cofob/minecraft:19 ghcr.io/cofob/minecraft:19
docker push cofob/minecraft:19
docker push ghcr.io/cofob/minecraft:19