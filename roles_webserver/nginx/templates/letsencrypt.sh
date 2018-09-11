#!/bin/bash

{% for domain in webserver_domains %}
certbot certonly --non-interactive --agree-tos --webroot -m {{ letsencrypt_mail }} -w /var/www/html/  -d {{ domain }}.void.ms
{% endfor %}
