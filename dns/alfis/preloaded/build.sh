#!/bin/bash
docker build -t cofob/alfis:latest .
docker tag cofob/alfis:latest cofob/alfis:preloaded
docker tag cofob/alfis:latest ghcr.io/cofob/alfis:latest
docker tag cofob/alfis:preloaded ghcr.io/cofob/alfis:preloaded
docker push cofob/alfis:latest
docker push cofob/alfis:preloaded
docker push ghcr.io/cofob/alfis:latest
docker push ghcr.io/cofob/alfis:preloaded