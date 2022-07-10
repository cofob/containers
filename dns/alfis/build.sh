#!/bin/bash
docker build -t cofob/alfis:bare .
docker tag cofob/alfis:bare ghcr.io/cofob/alfis:bare
docker push cofob/alfis:bare
docker push ghcr.io/cofob/alfis:bare

cd preloaded
docker build -t cofob/alfis:latest .
docker tag cofob/alfis:latest cofob/alfis:preloaded
docker tag cofob/alfis:latest ghcr.io/cofob/alfis:latest
docker tag cofob/alfis:preloaded ghcr.io/cofob/alfis:preloaded
docker push cofob/alfis:latest
docker push cofob/alfis:preloaded
docker push ghcr.io/cofob/alfis:latest
docker push ghcr.io/cofob/alfis:preloaded
cd ..
