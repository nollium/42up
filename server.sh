#!/usr/bin/bash

if ! [ -v PORT ];then
        PORT=8080
fi

export LAST_CHECK_TIME="$(date +%s)"
DELAY=2
if [ -v PROD ];then
        DELAY=10
fi
make_output()
{
        CURRENT_TIME="$(date +%s)"
        if [ -f /tmp/.bashttp_content ] && [ "$(($CURRENT_TIME - $LAST_CHECK_TIME))" -lt "$DELAY" ];then
                return 0
        fi
        CONTENT=$(./get_up_time.sh)
        OUTPUT=$(printf 'HTTP/1.1 200 OK\r\n\r\n
<html>
<head>
<title>intra.42.fr uptime</title>
</head>
<body style="background-image: url('"'https://cdn.intra.42.fr/coalition/cover/45/federation_background.jpg'"');">
%s
<footer style="font-size: 50px"><a style="color: yellow" href="https://github.com/Dirty-No/42up"> backend in bash btw </a> </footer></body>
</html>' "$CONTENT")
        echo "($(date '+%d/%m/%Y %H:%m:%S'))" "
------------------------------------------------------------------------------------
$CONTENT" "
------------------------------------------------------------------------------------" | tee -a /tmp/.bashttp_logs
        echo "$OUTPUT" > /tmp/.bashttp_content
        LAST_CHECK_TIME="$CURRENT_TIME"
}

echo Loading... 
make_output
echo Server running on port "$PORT"
while true;
        do
        nc -w 1 -l "$PORT" < /tmp/.bashttp_content
        make_output &
done

