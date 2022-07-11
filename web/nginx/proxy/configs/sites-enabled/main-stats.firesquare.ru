server {
	server_name main-stats.firesquare.ru;

	include snippets/main-proxy;
	include snippets/brotli;
	add_header X-Cache-Status $upstream_cache_status;

	location / {
		include snippets/main-pass;
		# Cache everything
		include snippets/proxy-cache;
	}
}
