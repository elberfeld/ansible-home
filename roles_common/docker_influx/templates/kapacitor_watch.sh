#!/bin/sh
# Show Kapacitor Task Logs
# Usage: ./kapacitor_watch.sh <task> 

docker-compose exec kapacitor kapacitor show $1

docker-compose exec kapacitor kapacitor reload $1
docker-compose exec kapacitor kapacitor watch $1
