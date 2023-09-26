#!/bin/bash
cur=$(cd "$(dirname "$0")"; pwd)

# cd $cur/sbin;
# ./nginx -V
# ./nginx -t
# # ./nginx


echo "val: nginx-echo.json.txt" > /tmp/nginx-echo.json.txt;
cd /rootfs/nginx/sbin/
./nginx -c $cur/nginx.conf

tail -f /dev/null