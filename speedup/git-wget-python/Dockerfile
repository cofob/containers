FROM            alpine AS git

LABEL           author="cofob" maintainer="cofob@riseup.net"
LABEL           org.opencontainers.image.source="https://github.com/cofob/containers"

WORKDIR         /src
RUN             apk add --no-cache git wget python3 && \
                wget -O load_plugins.py https://raw.githubusercontent.com/cofob/containers/master/minecraft/scripts/load_plugins.py
