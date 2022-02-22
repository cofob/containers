# Compiling
FROM		golang:bullseye AS builder

RUN			apt-get install gcc -y
RUN			go install github.com/neilalexander/yggmail/cmd/yggmail@latest


# Compressing binary
FROM		ghcr.io/cofob/upx AS upx
COPY		--from=builder /go/bin/yggmail /app.fat
RUN			upx --best --lzma -o /yggmail /app.fat


# Final image
FROM		debian:bullseye-slim

LABEL       author="cofob" maintainer="cofob@riseup.net"
LABEL       org.opencontainers.image.source="https://github.com/cofob/containers"

COPY		--from=upx /yggmail /bin/yggmail

VOLUME		[ "/storage" ]

WORKDIR		/storage

EXPOSE		1143/tcp
EXPOSE		1025/tcp
