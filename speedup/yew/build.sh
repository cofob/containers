#!/bin/bash
docker build -t cofob/yew:3 .
docker tag cofob/yew:3 ghcr.io/cofob/yew:3
#docker push cofob/yew:3
docker push ghcr.io/cofob/yew:3
