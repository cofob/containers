server {
	server_name firesquare.ru;
	include snippets/main-base;

	location / {
		proxy_pass http://localhost:9002;
		include proxy_params;
	}
}
