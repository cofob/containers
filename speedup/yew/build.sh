#!/bin/bash
docker build -t cofob/yew:2 .
docker tag cofob/yew:2 ghcr.io/cofob/yew:2
docker push cofob/yew:2
docker push ghcr.io/cofob/yew:2
