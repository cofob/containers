#!/bin/bash

docker build -t cofob/lila-gif:latest .
docker tag cofob/lila-gif:latest ghcr.io/cofob/lila-gif:latest
#docker push cofob/lila-gif:latest
docker push ghcr.io/cofob/lila-gif:latest
