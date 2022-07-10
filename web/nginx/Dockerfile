# Included:
#  - HTTP/3 support
#  - Accounting (https://github.com/Lax/traffic-accounting-nginx-module)
#  - Brotli (https://github.com/google/ngx_brotli)
#  - Markdown render on-the-fly (https://github.com/ukarim/ngx_markdown_filter_module)

FROM nginx:1.23.0 AS build

WORKDIR /src

RUN apt-get update && \
	apt-get install -y git gcc make g++ cmake perl libunwind-dev golang \
					   mercurial libperl-dev libpcre3-dev zlib1g-dev libxslt1-dev \
					   libgd-ocaml-dev libgeoip-dev libcmark-dev cmark \
					   wget ca-certificates curl

RUN git clone https://boringssl.googlesource.com/boringssl && \
	mkdir boringssl/build && \
	cd boringssl/build && \
	cmake .. && \
	make

RUN hg clone https://hg.nginx.org/nginx-quic   && \
	hg clone http://hg.nginx.org/njs -r "0.6.2" && \
	cd nginx-quic && \
	hg update quic

RUN git clone https://github.com/google/ngx_brotli.git

RUN git clone https://github.com/ukarim/ngx_markdown_filter_module.git

RUN cd nginx-quic && \
	auto/configure `nginx -V 2>&1 | sed "s/ \-\-/ \\\ \n\t--/g" | grep "\-\-" | grep -ve opt= -e param= -e build=` \
					--build=nginx-quic --with-debug  \
					--with-http_v3_module --with-stream_quic_module \
					--with-http_realip_module --with-http_v2_module \
					--with-http_sub_module --with-compat \
					--add-module=/src/ngx_brotli \
					--add-module=/src/ngx_markdown_filter_module \
					--with-cc-opt="-I/src/boringssl/include" --with-ld-opt="-L/src/boringssl/build/ssl -L/src/boringssl/build/crypto" && \
	make && make modules

RUN mkdir modules && \
	wget https://github.com/Lax/traffic-accounting-nginx-module/releases/download/v2.0/ngx_http_accounting_module.so

FROM nginx:1.23.0

LABEL author="cofob" maintainer="cofob@riseup.net"
LABEL org.opencontainers.image.source="https://github.com/cofob/containers"

RUN apt-get update && apt-get install libcmark-dev -y

COPY --from=build /src/nginx-quic/objs/nginx /usr/sbin
COPY --from=build /src/modules/ /etc/bundled/modules/
