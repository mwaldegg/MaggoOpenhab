#!/bin/sh

READLINK=`which readlink`
SCRIPT_LOCATION=$0
if [ -x "$READLINK" ]; then
  while [ -L "$SCRIPT_LOCATION" ]; do
    SCRIPT_LOCATION=`"$READLINK" -e "$SCRIPT_LOCATION"`
  done
fi

cd `dirname "$SCRIPT_LOCATION"`
java -jar hambisync.jar
