#!/bin/bash
docker build -t cofob/devcontainer-debian-libvirt .
docker tag cofob/devcontainer-debian-libvirt ghcr.io/cofob/devcontainer-debian-libvirt
docker push cofob/devcontainer-debian-libvirt
docker push ghcr.io/cofob/devcontainer-debian-libvirt
