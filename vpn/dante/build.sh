#!/bin/bash
docker build -t cofob/dante .
docker tag cofob/dante ghcr.io/cofob/dante
docker push cofob/dante
docker push ghcr.io/cofob/dante