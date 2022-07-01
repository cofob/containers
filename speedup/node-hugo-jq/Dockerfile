FROM            node:18

LABEL           author="cofob" maintainer="cofob@riseup.net"
LABEL           org.opencontainers.image.source="https://github.com/cofob/containers"

RUN             apt-get update && apt-get install jq curl wget python3 python3-pip -y && \
                wget https://github.com/gohugoio/hugo/releases/download/v0.101.0/hugo_extended_0.101.0_Linux-64bit.deb -O hugo.deb && \
                dpkg -i hugo.deb && rm -f hugo.deb && \
                npm install -g ipfs-car && npm install -g cloudflare-cli && npm install -g wrangler && pip install cloudflare
