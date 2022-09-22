#!/bin/bash
docker build -t cofob/deta .
docker tag cofob/deta ghcr.io/cofob/deta
docker push cofob/deta
docker push ghcr.io/cofob/deta
