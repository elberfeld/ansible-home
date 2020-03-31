#!/bin/bash
response=$(curl --write-out %{http_code} --silent \
-F "token=$PUSHOVERTOKEN" \
-F "user=$PUSHOVERUSER" \
-F "title=$PUSHOVERTITLE" \
-F "message=$PUSHOVERMESSAGE" \
https://api.pushover.net/1/messages)
if [[ "$response" == *200 ]]
then
    echo Pushover message sent succesfully
    exit 0
else
    echo Activation of Pushover service failed. This is the response from Pushover: $response
    exit 1
fi