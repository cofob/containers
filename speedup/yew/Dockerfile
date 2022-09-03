FROM rust
RUN rustup target add wasm32-unknown-unknown && \
    wget https://github.com/thedodd/trunk/releases/download/v0.16.0/trunk-x86_64-unknown-linux-gnu.tar.gz -O trunk.tar.gz && \
    tar -xzvf trunk.tar.gz && \
    rm -f trunk.tar.gz && \
    chmod u+x trunk && \
    mv trunk /bin && \
    apt-get update && \
    apt-get install python3 python3-pip curl -y && \
    pip install css-html-js-minify && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get update && \
    apt install nodejs -y
