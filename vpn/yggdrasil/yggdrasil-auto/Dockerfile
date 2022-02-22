# Git cloning
FROM		alpine AS code-cloner

WORKDIR		/src

RUN			apk add --no-cache git
RUN			git clone https://github.com/popura-network/Popura.git code && cd code && git fetch && \
			git switch auto 


# Compiling
FROM		golang:1.17-alpine AS builder
ENV			CGO_ENABLED=0

COPY		--from=code-cloner /src /src
WORKDIR		/src/code

RUN			./build && rm -rf /root /go


# Compressing binary
FROM		ghcr.io/cofob/upx as upx
COPY		--from=builder /src/code/yggdrasil /app.fat
COPY		--from=builder /src/code/yggdrasilctl /appctl.fat
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
