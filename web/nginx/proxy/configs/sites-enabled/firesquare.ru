server {
	server_name firesquare.ru;
	include snippets/main-base;

	location /_app/immutable {
		include snippets/main-pass;
		include snippets/proxy-cache;
	}
}
