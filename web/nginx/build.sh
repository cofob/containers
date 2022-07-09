#!/bin/bash
docker build -t cofob/nginx .
docker tag cofob/nginx ghcr.io/cofob/nginx
docker push cofob/nginx
docker push ghcr.io/cofob/nginx