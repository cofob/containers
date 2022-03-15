FROM wernight/dante as iner
COPY ./sockd.conf /etc/sockd.conf
CMD printf "${PASSWORD}\n${PASSWORD}\n" | adduser ${USERNAME} && \
    sockd
