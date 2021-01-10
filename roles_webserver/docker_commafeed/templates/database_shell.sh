#!/bin/sh

echo Lock entfernen:
echo update DATABASECHANGELOGLOCK set LOCKED=false, LOCKGRANTED=null, LOCKEDBY=null where ID=1;

docker-compose exec app /usr/bin/java -cp /home/commafeed/h2-1.4.197.jar org.h2.tools.Shell -url jdbc:h2:/home/commafeed/db -user sa -password sa
