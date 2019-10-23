#!/bin/bash

#Maggos Iphone8 (2019-09)  80:4A:14:EF:B5:48
#Apple Watch 3: 98:00:C6:00:DB:EF


#if [ "$1" != -v ]; then
#  param="1"
#else
#  param=$1
#fi

param=$1
#echo $param

/usr/bin/l2ping -c 1 -c2 -s32 -t1 $param &> /dev/null
if [ $? -ne 0 ]
   then
      echo "OFF"
      exit 0
   else
      echo "ON"
      exit 1
fi

