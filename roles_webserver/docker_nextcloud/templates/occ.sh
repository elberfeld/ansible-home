#!/bin/bash

# Wrapper zur ausführung des OCC Kommendos im Docker 
docker-compose exec app su www-data -s "/bin/sh" -c "php /var/www/html/occ $1 $2 $3"
