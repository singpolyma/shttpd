# Serve static files with shttpd

if [ -f "$PATH_TRANSLATED" -a -r "$PATH_TRANSLATED" ]; then
	printf "%b" "HTTP/1.1 200 OK\r\n"
	printf "%b" "Content-Type: `file -b --mime "$PATH_TRANSLATED"`\r\n"
	printf "%b" "Content-Length: `wc -c "$PATH_TRANSLATED"`\r\n\r\n"
	cat "$PATH_TRANSLATED"
	exit
fi
