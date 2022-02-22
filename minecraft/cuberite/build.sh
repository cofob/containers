#!/bin/bash
docker build -t cofob/minecraft:cuberite .
docker tag cofob/minecraft:cuberite ghcr.io/cofob/minecraft:cuberite
docker push cofob/minecraft:cuberite
docker push ghcr.io/cofob/minecraft:cuberite