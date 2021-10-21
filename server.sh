#!/usr/bin/bash

if ! [ -v PORT ];then
        PORT=8080
fi

export LAST_CHECK_TIME="$(date +%s)"

make_output()
{
        CURRENT_TIME="$(date +%s)"
        #if (CURRENT_TIME - LAST_CHECK_TIME) > 2

        if [ -f /tmp/.bash_http_server_content ] && [ "$(($CURRENT_TIME - $LAST_CHECK_TIME))" -lt 2 ];then
                return 0
        fi
        LAST_CHECK_TIME="$CURRENT_TIME"
        CONTENT=$(./get_up_time.sh)
        OUTPUT=$(printf 'HTTP/1.1 200 OK\r\n\r\n
<html>
<head>
<title>intra.42.fr uptime</title>
</head>
<body>
<PRE>
%s
</PRE>
<footer><a href="https://github.com/Dirty-No/is_intra.42.fr_up"> backend in bash btw </a> </footer>
</body>
</html>' "$CONTENT")
        echo "($(date '+%d/%m/%Y %H:%m:%S'))" "
------------------------------------------------------------------------------------
$CONTENT" "
------------------------------------------------------------------------------------" | tee -a logs
        echo "$OUTPUT" > /tmp/.bash_http_server_content
}

echo Server running on port "$PORT"
while true;
        do
        make_output &
        nc -w 1 -l "$PORT" < /tmp/.bash_http_server_content
done

