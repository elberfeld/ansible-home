#!/bin/sh
# Influx Admin Konsole 
# Usage: ./influx.sh 

docker-compose exec db influx -database "influx" -password "{{ influx_admin_pw }}" -username "admin"
