#!/bin/bash
docker build -t cofob/ipfs-tools .
docker tag cofob/ipfs-tools ghcr.io/cofob/ipfs-tools
docker push cofob/ipfs-tools
docker push ghcr.io/cofob/ipfs-tools
