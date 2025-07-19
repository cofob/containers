FROM golang:latest AS builder
WORKDIR /app

ARG DERP_VERSION=latest
RUN go install tailscale.com/cmd/derpprobe@${DERP_VERSION}

FROM debian:bookworm-slim

COPY --from=builder /go/bin/derpprobe /bin/derpprobe

CMD /app/derpprobe
