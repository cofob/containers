FROM        alpine

LABEL       author="cofob" maintainer="cofob@riseup.net"
LABEL       org.opencontainers.image.source="https://github.com/cofob/containers"

RUN         apk add --no-cache upx

ENTRYPOINT  [ "/usr/bin/upx" ]
