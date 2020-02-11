#!/bin/sh 

cd /srv/icinga 
docker-compose exec app icinga2 feature disable debuglog
docker-compose restart 
rm log/icinga2/debug.log
