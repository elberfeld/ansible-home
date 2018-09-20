#!/bin/sh
# Show Kapacitor Task
# Usage: ./kapacitor_show.sh <task> 

docker-compose exec kapacitor kapacitor show $1
