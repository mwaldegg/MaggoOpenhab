#!/bin/bash
a=$(curl -s 192.168.200.200/api/47-lnYtNWWwmLFHVZV08Xtk2ZJwBCaX5dZa5EKXn/lights)
echo $a | grep -o -P  "\"name.*?[,]" > 0
echo $a | egrep -o  "\"[0-9]{1,2}\":{1}" >1
paste 1 0 | sed 's/\([":,]\|name\)//g'
rm 1 0
