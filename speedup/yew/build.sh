#!/bin/bash
docker build -t cofob/yew .
docker tag cofob/yew ghcr.io/cofob/yew
docker push cofob/yew
docker push ghcr.io/cofob/yew
