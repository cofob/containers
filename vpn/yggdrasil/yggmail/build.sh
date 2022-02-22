#!/bin/bash
docker build -t cofob/yggmail .
docker tag cofob/yggmail ghcr.io/cofob/yggmail
docker push cofob/yggmail
docker push ghcr.io/cofob/yggmail