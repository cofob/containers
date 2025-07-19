#!/bin/bash
docker build -t cofob/ts-derper .
docker tag cofob/ts-derper ghcr.io/cofob/ts-derper
docker push cofob/ts-derper
docker push ghcr.io/cofob/ts-derper