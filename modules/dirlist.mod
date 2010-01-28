# Add directory listing support to shttpd

ls_switches="-oghF"

if [ -d "$PATH_TRANSLATED" ]; then
	if [ -n "$path" -a "`echo "$path" | cut -c${#path}-`" != / ]; then
		printf "%b" "HTTP/1.1 301 Redirect\r\n"
		printf "%b" "Location: /$path/\r\n"
		exit
	fi
	printf "%b" "HTTP/1.1 200 OK\r\n"
	printf "%b" "Content-Type: text/html\r\n\r\n"
	echo "<html><head>"
	echo "<title>/$path - Listing</title>"
	echo "<style type=\"text/css\">li { font-family: monospace; }</style>"
	echo "</head><body>"
	IFS="
"
	echo "<ul>"
	for FILE in ./"${path:-.}"/*; do
		if [ -d "$FILE" ]; then
			append=/
		else
			append=
		fi
		echo "<li><a href=\"`basename $FILE`$append\">$(cd "`dirname "$FILE"`"; ls $ls_switches -d "`basename $FILE`")</a></li>"
	done
	echo "</ul>"
	echo "</body></html>"
	exit
fi
