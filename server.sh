#!/usr/bin/bash

if ! [ -v PORT ];then
        PORT=8080
fi

echo Server running on port "$PORT"
while true;
        do

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
<footer> backend in bash btw </footer>
</body>
</html>' "$CONTENT")
        echo CONTENT READY: "$CONTENT"
        echo "$OUTPUT" | nc -w 1 -l "$PORT"
done

