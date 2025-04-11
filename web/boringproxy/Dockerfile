FROM golang:1.24.2-alpine3.21 as builder
LABEL boringproxy=builder

ARG VERSION
ARG GOOS="linux"
ARG GOARCH="amd64"
ARG BRANCH="master"
ARG REPO="https://github.com/boringproxy/boringproxy.git"
ARG ORIGIN='local'

WORKDIR /build

RUN apk add git

RUN if [[ "ORIGIN" == 'remote' ]] ; then git clone --depth 1 --branch "${BRANCH}" ${REPO}; fi

COPY go.* ./
RUN go mod download
COPY . .

RUN cd cmd/boringproxy && CGO_ENABLED=0 GOOS=${GOOS} GOARCH=${GOARCH} \
	go build -ldflags "-X main.Version=${VERSION}" \
	-o boringproxy

FROM alpine:3.21
EXPOSE 80 443
WORKDIR /storage

COPY --from=builder /build/cmd/boringproxy/boringproxy /

ENTRYPOINT ["/boringproxy"]
CMD ["version"]