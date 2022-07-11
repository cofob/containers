server {
	server_name wiki.firesquare.ru;
	include snippets/main-base;

	location /lib {
		include snippets/main-pass;
		include snippets/proxy-cache;
	}
}
