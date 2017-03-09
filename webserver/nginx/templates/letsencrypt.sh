#!/bin/bash

cd /opt/simp_le/ 
if [ ! -e venv/bin/python ]; then ./venv.sh; fi 

cd /etc/ssl 
PATH=/opt/simp_le/venv/bin:/usr/sbin:/usr/bin:/sbin:/bin 

simp_le --email {{ letsencrypt_mail }} -f account_key.json -f key.pem -f fullchain.pem --tos_sha256 {{ letsencrypt_tos_sha256 }} {% for domain in webserver_domains %} -d {{ domain }}.void.ms:/var/www/html {% endfor %} && systemctl reload nginx

