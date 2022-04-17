# Blockchain loading
FROM		alpine AS blockchain
WORKDIR		/
RUN			apk add --no-cache wget
RUN			wget --inet4-only -O blockchain.db https://viewer.alfis.name/blockchain.db

# Final image
FROM		ghcr.io/cofob/alfis:bare

LABEL       author="cofob" maintainer="cofob@riseup.net"
LABEL       org.opencontainers.image.source="https://github.com/cofob/containers"

COPY		--from=blockchain /blockchain.db /storage/blockchain.db

EXPOSE		53/tcp
EXPOSE		53/udp

WORKDIR		/storage
VOLUME		[ "/storage" ]
