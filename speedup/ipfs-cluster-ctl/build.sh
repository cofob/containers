#!/bin/bash
docker build -t cofob/ipfs-cluster-ctl .
docker tag cofob/ipfs-cluster-ctl ghcr.io/cofob/ipfs-cluster-ctl
#docker push cofob/ipfs-cluster-ctl
docker push ghcr.io/cofob/ipfs-cluster-ctl
