#!/bin/bash
docker build -t cofob/tailwind .
docker tag cofob/tailwind ghcr.io/cofob/tailwind
docker push cofob/tailwind
docker push ghcr.io/cofob/tailwind
