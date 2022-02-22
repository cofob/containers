#!/bin/bash
docker build -t cofob/alfis:bare .
docker tag cofob/alfis:bare ghcr.io/cofob/alfis:bare
docker push cofob/alfis:bare
docker push ghcr.io/cofob/alfis:bare