# Git cloning
FROM		alpine AS code-cloner

WORKDIR		/src

RUN			apk add --no-cache git
RUN			git clone https://github.com/yggdrasil-network/yggdrasil-go


# Compiling
FROM		golang:1.17-alpine AS builder
ENV			CGO_ENABLED 0
ENV			TZ=Europe/Moscow

COPY		--from=code-cloner /src /src
WORKDIR		/src/yggdrasil-go
RUN			./build && rm -rf /root /go


# Compressing binary
FROM		ghcr.io/cofob/upx as upx
COPY		--from=builder /src/yggdrasil-go/yggdrasil /app.fat
COPY		--from=builder /src/yggdrasil-go/yggdrasilctl /appctl.fat
RUN			upx --best --lzma -o /yggdrasil /app.fat
RUN			upx --best --lzma -o /yggdrasilctl /appctl.fat


# Intermidate image
# Compressing layers
FROM		alpine as inter

WORKDIR     /
COPY		--from=upx /yggdrasil /yggdrasil
COPY		--from=upx /yggdrasilctl /yggdrasilctl
COPY		--from=builder /var /var
COPY		--from=builder /run /run
COPY		./entrypoint.sh entrypoint.sh


# Final image
FROM		scratch

LABEL       author="cofob" maintainer="cofob@riseup.net"
LABEL       org.opencontainers.image.source="https://github.com/cofob/containers"

COPY		--from=inter / /

VOLUME		[ "/config" ]
ENTRYPOINT	[ "sh", "/entrypoint.sh" ]
