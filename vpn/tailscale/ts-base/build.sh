git clone https://github.com/tailscale/mkctr

cd mkctr/

go build

go get tailscale.com/cmd/tailscale
go get tailscale.com/cmd/tailscaled
go get tailscale.com/cmd/derper
go get tailscale.com/cmd/derpprobe

./mkctr \
  --base="alpine:latest" \
  --gopaths="\
    tailscale.com/cmd/tailscale:/usr/local/bin/tailscale, \
    tailscale.com/cmd/tailscaled:/usr/local/bin/tailscaled, \
    tailscale.com/cmd/derper:/usr/local/bin/derper, \
    tailscale.com/cmd/derpprobe:/usr/local/bin/derpprobe" \
  --tags="latest" \
  --repos="ghcr.io/cofob/tailscale-base" \
  --push

cd ..