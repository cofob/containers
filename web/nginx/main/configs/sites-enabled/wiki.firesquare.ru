server {
	server_name wiki.firesquare.ru;
	include snippets/main-base;

	location / {
		proxy_pass http://localhost:8003;
		include proxy_params;
	}
}
