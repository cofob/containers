FROM		openjdk:11-slim-bullseye

LABEL       author="cofob" maintainer="cofob@riseup.net"
LABEL       org.opencontainers.image.source="https://github.com/cofob/containers"

RUN 		apt-get update -y && \
			apt-get install -y --no-install-recommends curl ca-certificates openssl tar fdupes \
				sqlite3 fontconfig libfreetype6 tzdata iproute2 libstdc++6 python3 wget git && \
			useradd -d /home/container -m container && mkdir /data && \
			chown -R container:container /data && chmod -R 777 /data

USER		container
ENV			USER=container HOME=/home/container
WORKDIR		/home/container

COPY		./entrypoint.sh /entrypoint.sh
COPY		./load_plugins.py /load_plugins.py
COPY		./apply_secrets.py /apply_secrets.py

ENV			STARTUP="java -jar server.jar" STAGING=""

CMD			[ "/bin/bash", "/entrypoint.sh" ]
