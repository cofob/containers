#!/bin/bash
docker build -t cofob/trunk .
docker tag cofob/trunk ghcr.io/cofob/trunk
docker push cofob/trunk
docker push ghcr.io/cofob/trunk
