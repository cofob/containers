#!/bin/bash
docker build -t cofob/yew:1 .
docker tag cofob/yew:1 ghcr.io/cofob/yew:1
docker push cofob/yew:1
docker push ghcr.io/cofob/yew:1
