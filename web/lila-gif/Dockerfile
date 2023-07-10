FROM rust:1-slim-buster as builder

RUN apt-get update && apt-get install -y \
	git \
	&& rm -rf /var/lib/apt/lists/*
RUN git clone --recurse-submodules https://github.com/lichess-org/lila-gif.git /lila-gif

WORKDIR /lila-gif

RUN cargo build --release


FROM debian:buster-slim

ENV BIND=0.0.0.0:6175
EXPOSE 6175

RUN apt-get update && apt-get install -y \
	ca-certificates \
	&& rm -rf /var/lib/apt/lists/*

COPY --from=builder /lila-gif/target/release/lila-gif /bin/lila-gif

CMD lila-gif --bind $BIND
