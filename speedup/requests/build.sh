#!/bin/bash
docker build -t cofob/requests .
docker tag cofob/requests ghcr.io/cofob/requests
#docker push cofob/requests
docker push ghcr.io/cofob/requests
