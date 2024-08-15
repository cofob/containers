#!/bin/bash
docker build -t cofob/kickstart .
docker tag cofob/kickstart ghcr.io/cofob/kickstart
docker push cofob/kickstart
docker push ghcr.io/cofob/kickstart
