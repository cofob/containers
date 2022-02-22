#!/bin/bash
docker build -t cofob/yggdrasil .
# "magic" fix https://github.com/moby/moby/issues/37965#issuecomment-436200078
docker build -t cofob/yggdrasil .
docker tag cofob/yggdrasil ghcr.io/cofob/yggdrasil
docker push cofob/yggdrasil
docker push ghcr.io/cofob/yggdrasil