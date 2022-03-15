FROM wernight/dante as iner
COPY ./sockd.conf /etc/sockd.conf
RUN printf "${PASSWORD}\n${PASSWORD}\n" | adduser ${USERNAME}

# compressing layers
FROM scratch
COPY --from=iner / /
