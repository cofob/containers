#!/bin/bash
cp -r ../scripts/* .
docker build -t cofob/minecraft:11 .
docker tag cofob/minecraft:11 ghcr.io/cofob/minecraft:11
docker push cofob/minecraft:11
docker push ghcr.io/cofob/minecraft:11