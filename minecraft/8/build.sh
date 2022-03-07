#!/bin/bash
cp -r ../scripts/* .
docker build -t cofob/minecraft:8 .
docker tag cofob/minecraft:8 ghcr.io/cofob/minecraft:8
docker push cofob/minecraft:8
docker push ghcr.io/cofob/minecraft:8