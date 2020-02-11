#!/bin/sh 

cd /srv/icinga 
docker-compose exec app icinga2 feature enable debuglog
docker-compose restart 
tail -f log/icinga2/debug.log
