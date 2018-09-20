#!/bin/bash

/usr/bin/docker exec -t nextcloud_app_1 su www-data -s "/bin/sh" -c "php /var/www/html/occ fulltextsearch:live"
