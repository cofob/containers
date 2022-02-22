#!/bin/bash
docker build -t cofob/yggdrasil:auto .
# "magic" fix https://github.com/moby/moby/issues/37965#issuecomment-436200078
docker build -t cofob/yggdrasil:auto .
docker tag cofob/yggdrasil:auto ghcr.io/cofob/yggdrasil:auto
docker push cofob/yggdrasil:auto
docker push ghcr.io/cofob/yggdrasil:auto