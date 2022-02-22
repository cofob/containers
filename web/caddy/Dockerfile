# Compiling
FROM		golang:1.17-alpine AS builder
ENV			CGO_ENABLED 0
ENV			TZ=Europe/Moscow

WORKDIR		/build
RUN			go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest
RUN			xcaddy build \
				--with github.com/caddy-dns/cloudflare \
				--with github.com/caddy-plugins/caddy-rate-limit \
				--with github.com/ueffel/caddy-brotli


# Final image
FROM		caddy

LABEL       author="cofob" maintainer="cofob@riseup.net"
LABEL       org.opencontainers.image.source="https://github.com/cofob/containers"

COPY		--from=builder /build/caddy /usr/bin/caddy
