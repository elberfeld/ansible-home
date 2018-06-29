#!/bin/sh
# Influx Admin Konsole 
# Usage: ./influx_sysmon.sh 

docker-compose exec sysmon influx -database "{{influxdb_sysmon.db}}" -password "{{ influx_admin_pw }}" -username "admin"
