#!/bin/bash

wall "cmd: $1"

if [ "$1" == "on" ] || [ "$1" == "off" ] ; then 
  curl http://192.168.200.153:4567/$1
fi

if [ "$1" == "start" ] || [ "$1" == "restart" ] || [ "$1" == "stop" ]; then
  sudo systemctl $1 hambisync.service 
fi
