server {
	server_name main-stats.firesquare.ru;

	include snippets/main-proxy;
	include snippets/brotli;
	include snippets/cache-status;

	location / {
		include snippets/main-pass;
		# Cache everything
		include snippets/proxy-cache;
	}
}
