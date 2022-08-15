#!/bin/bash
docker build -t cofob/nixfmt .
docker tag cofob/nixfmt ghcr.io/cofob/nixfmt
docker push cofob/nixfmt
docker push ghcr.io/cofob/nixfmt
