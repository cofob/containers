#!/bin/bash
docker build -t cofob/nginx .
docker tag cofob/nginx ghcr.io/cofob/nginx
docker push cofob/nginx
docker push ghcr.io/cofob/nginx

# cd main
# docker build -t cofob/nginx:main .
# docker tag cofob/nginx:main ghcr.io/cofob/nginx:main
# docker push cofob/nginx:main
# docker push ghcr.io/cofob/nginx:main
# cd ..

cd proxy
docker build -t cofob/nginx:proxy .
docker tag cofob/nginx:proxy ghcr.io/cofob/nginx:proxy
docker push cofob/nginx:proxy
docker push ghcr.io/cofob/nginx:proxy
cd ..
