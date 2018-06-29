#!/bin/sh
# Show Kapacitor Task Logs
# Usage: ./kapacitor_watch.sh <task> 

docker-compose exec app kapacitor show $1

docker-compose exec app kapacitor reload $1
docker-compose exec app kapacitor watch $1
