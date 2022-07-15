#!/bin/bash
cur=$(cd "$(dirname "$0")"; pwd)

cd $cur/sbin;
./nginx -V
./nginx -t
# ./nginx
