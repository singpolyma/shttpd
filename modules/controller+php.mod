# Bind controllers in any language to views in PHP
# Requires cgi.mod

controller="`echo "$path" | cut -d/ -f1`"
action="`echo "$path" | cut -d/ -f2-`"
if [ -z "$controller" ]; then
	controller=main
fi
if [ -z "$action" -o "$action" = "$controller" ]; then
	action=index
fi

if [ -x "controllers/$controller" ]; then
	CONTROLLER_VARS="`call_cgi -n "controllers/$controller" "$action"`"
	if [ $? -eq 0 ]; then
		if [ -r "views/$controller/$action.php" ]; then
			REDIRECT_STATUS="200"
			export REDIRECT_STATUS CONTROLLER_VARS
			script="`mktemp -t shttpd$$.php.XXXXXX`"
			echo "<?php 
				if(\$_SERVER['CONTROLLER_VARS']{0} == '{')
					extract(json_decode(\$_SERVER['CONTROLLER_VARS'], true));
				else
					parse_str(\$_SERVER['CONTROLLER_VARS']);
				?>" > "$script"
			cat "views/$controller/$action.php" >> "$script"
			PATH_TRANSLATED="$script"
			call_cgi php-cgi "$script"
		else
			echo "$CONTROLLER_VARS"
		fi
	else
		echo "$CONTROLLER_VARS" 1>&2
		echo "$CONTROLLER_VARS"
	fi
	exit
fi
