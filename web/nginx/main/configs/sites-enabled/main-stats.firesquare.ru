server {
	server_name main-stats.firesquare.ru;
	include snippets/main-base;

	location / {
		proxy_pass http://localhost:8804;
		include proxy_params;
	}
}
