#!/bin/bash
docker build -t cofob/wrangler .
docker tag cofob/wrangler ghcr.io/cofob/wrangler
#docker push cofob/wrangler
docker push ghcr.io/cofob/wrangler
