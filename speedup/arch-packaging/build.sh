#!/bin/bash
docker build -t cofob/archlinux .
docker tag cofob/archlinux ghcr.io/cofob/archlinux
docker push cofob/archlinux
docker push ghcr.io/cofob/archlinux
