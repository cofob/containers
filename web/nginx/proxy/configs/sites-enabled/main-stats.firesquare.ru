server {
	server_name main-stats.firesquare.ru;

	include snippets/main-proxy;
	include snippets/brotli;

	location / {
		include snippets/main-pass;
		include snippets/basic-auth;
	}
}
