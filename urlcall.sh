#!/bin/bash
#Call openhab Rest API
#Usage: urlcall.sh <item> <cmd>

LOG="/tmp/urlcall.log"
echo "-----------------------" >> $LOG 2>&1
echo $(date)  >> $LOG 2>&1
echo "Called: $0 $*" >> $LOG 2>&1

if [ -z "$1" ] || [ -z "$2" ]
then
      echo "Missing Parameter!"
      echo "Usage: $0 <item> <cmd>"
      exit 1
else
	ITEM=$1
	CMD=$2
	echo "executing: curl --header "Content-Type: text/plain" --request POST --data "$CMD" http://openhab:8080/rest/items/$ITEM"  >> $LOG 2>&1
      curl --header "Content-Type: text/plain" --request POST --data "$CMD" http://openhab:8080/rest/items/$ITEM
      exit $?
fi


