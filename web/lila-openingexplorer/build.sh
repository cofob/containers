#!/bin/bash

docker build -t cofob/lila-openingexplorer:latest .
docker tag cofob/lila-openingexplorer:latest ghcr.io/cofob/lila-openingexplorer:latest
#docker push cofob/lila-openingexplorer:latest
docker push ghcr.io/cofob/lila-openingexplorer:latest
