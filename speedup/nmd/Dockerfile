FROM            nixos/nix

LABEL           author="cofob" maintainer="cofob@riseup.net"
LABEL           org.opencontainers.image.source="https://github.com/cofob/containers"

RUN nix-shell -p git && git clone https://git.frsqr.xyz/firesquare/mineflake && cd mineflake && nix-build -A docs.html && cd .. && rm -rf mineflake
