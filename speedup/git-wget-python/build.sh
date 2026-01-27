#!/bin/bash
docker build -t cofob/git-wget-python .
docker tag cofob/git-wget-python ghcr.io/cofob/git-wget-python
#docker push cofob/git-wget-python
docker push ghcr.io/cofob/git-wget-python
