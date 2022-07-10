# Git cloning
FROM		alpine AS code-cloner

WORKDIR		/src
RUN			apk add --no-cache git 
RUN			git clone https://github.com/Revertron/Alfis


# Compiling
FROM		rust:slim-bullseye AS builder

RUN			apt-get update && apt-get install pkg-config libcairo2-dev -y
COPY		--from=code-cloner /src/Alfis /src
WORKDIR		/src
RUN			cargo build --release --no-default-features --features="doh"


# Compressing binary
FROM		gruebel/upx as upx
COPY		--from=builder /src/target/release/alfis /app.fat
RUN			upx --best --lzma -o /alfis /app.fat


# Inter image
FROM		scratch as inter

COPY		--from=upx /alfis /alfis
COPY		--from=debian:bullseye-slim /lib64 /lib64
COPY		--from=debian:bullseye-slim /lib /lib
COPY		alfis.toml /storage/alfis.toml


# Final image
FROM		scratch

COPY		--from=inter / /

LABEL       author="cofob" maintainer="cofob@riseup.net"
LABEL       org.opencontainers.image.source="https://github.com/cofob/containers"

EXPOSE		4244/tcp
EXPOSE		53/tcp
EXPOSE		53/udp

WORKDIR		/storage
VOLUME		[ "/storage" ]

CMD			[ "/alfis", "-c", "/storage/alfis.toml" ]
