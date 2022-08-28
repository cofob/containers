FROM            nixos/nix

LABEL           author="cofob" maintainer="cofob@riseup.net"
LABEL           org.opencontainers.image.source="https://github.com/cofob/containers"

COPY src/ .
RUN ls && cd data && nix-build -A docs.html || true && cd .. && rm -rf src
