#!/usr/bin/bash

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
</body>
</html>' "$CONTENT")

        echo "$OUTPUT" | nc -w 1 -l 8080
done

