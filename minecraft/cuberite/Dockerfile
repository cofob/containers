# Download latest cuberite and extract it
FROM		debian:bullseye-slim AS downloader

WORKDIR		/cuberite

RUN			apt-get update && apt-get install -y wget tar
RUN			wget --inet4-only -O cuberite.tar.gz https://download.cuberite.org/linux-x86_64/Cuberite.tar.gz
RUN			tar -xvf cuberite.tar.gz
RUN			rm -f .wget-hsts cuberite.tar.gz
RUN			mv Cuberite cuberite
RUN			chmod u+x cuberite

# Final image
FROM		debian:bullseye-slim

LABEL       author="cofob" maintainer="cofob@riseup.net"
LABEL       org.opencontainers.image.source="https://github.com/cofob/containers"

RUN			groupadd -g 5000 container && useradd -d /home/container -m -g container -u 5000 container

USER		container
ENV			USER=container HOME=/home/container
WORKDIR		/home/container

EXPOSE		25565
EXPOSE		8080

VOLUME		/home/container

COPY		--from=downloader /cuberite /home/container
CMD			./cuberite
