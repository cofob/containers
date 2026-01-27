#!/bin/bash
docker build -t cofob/node-hugo-jq .
docker tag cofob/node-hugo-jq ghcr.io/cofob/node-hugo-jq
#docker push cofob/node-hugo-jq
docker push ghcr.io/cofob/node-hugo-jq
