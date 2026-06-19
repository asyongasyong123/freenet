#!/bin/bash
set -e
sed -i "s/listen 8080;/listen ${PORT};/g" /etc/nginx/nginx.conf
xray run -c /etc/xray/config.json &
nginx -g 'daemon off;'
