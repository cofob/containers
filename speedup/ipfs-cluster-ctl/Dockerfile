FROM debian:bullseye
RUN apt-get update && apt-get install wget curl -y && wget -O ctl.tar.gz https://dist.ipfs.tech/ipfs-cluster-ctl/v1.0.3/ipfs-cluster-ctl_v1.0.3_linux-amd64.tar.gz && \
    tar -xzvf ctl.tar.gz && mv ipfs-cluster-ctl/ipfs-cluster-ctl /bin/ipfs-cluster-ctl && chmod u+x /bin/ipfs-cluster-ctl && rm -rf ipfs-cluster-ctl ctl.tar.gz
