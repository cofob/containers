#!/bin/bash
docker build -t cofob/obsidian-mcp .
docker tag cofob/obsidian-mcp ghcr.io/cofob/obsidian-mcp
#docker push cofob/obsidian-mcp
docker push ghcr.io/cofob/obsidian-mcp
