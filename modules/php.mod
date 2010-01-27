# PHP-CGI module for shttpd
# Requires CGI module to be loaded

if echo "$PATH_TRANSLATED" | grep '.*\.php' > /dev/null; then
	if [ -e "$PATH_TRANSLATED" ]; then
		REDIRECT_STATUS="200"
		export REDIRECT_STATUS
	fi
	call_cgi php-cgi "$PATH_TRANSLATED"
	exit
fi
