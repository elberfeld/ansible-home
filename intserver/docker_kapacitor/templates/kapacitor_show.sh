#!/bin/sh
# Show Kapacitor Task
# Usage: ./kapacitor_show.sh <task> 

docker-compose exec app kapacitor show $1
