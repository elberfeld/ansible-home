#!/bin/sh
# Show Kapacitor Tasks
# Usage: ./kapacitor_listtasks.sh 

docker-compose exec kapacitor kapacitor list tasks
