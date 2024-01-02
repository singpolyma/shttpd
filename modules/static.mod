# Serve static files with shttpd

if [ -f "$PATH_TRANSLATED" -a -r "$PATH_TRANSLATED" ]; then
	printf "%b" "HTTP/1.1 200 OK\r\n"
	printf "%b" "Content-Type: `file -b --mime "$PATH_TRANSLATED"`\r\n"
	printf "%b" "Content-Length: `wc -c < "$PATH_TRANSLATED"`\r\n"
	printf "%b" "Expires: `date -uRd '1 hour'`\r\n"
	if type md5sum > /dev/null 2>&1; then
		printf "%b" "ETag: \"`md5sum < "$PATH_TRANSLATED"`\"\r\n"
	elif type md5 > /dev/null 2>&1; then
		printf "%b" "ETag: \"`md5 -q "$PATH_TRANSLATED"`\"\r\n"
	fi
	printf "%b" "\r\n"
	cat "$PATH_TRANSLATED"
	exit
fi
