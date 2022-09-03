FROM rust
RUN rustup target add wasm32-unknown-unknown && \
    wget https://github.com/thedodd/trunk/releases/download/v0.16.0/trunk-x86_64-unknown-linux-gnu.tar.gz -O trunk.tar.gz && \
    tar -xzvf trunk.tar.gz && \
    rm -f trunk.tar.gz && \
    chmod u+x trunk && \
    mv trunk /bin && \
    apt-get update && \
    apt-get install python3 python3-pip curl -y && \
    pip install css-html-js-minify
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
RUN nvm use 18
