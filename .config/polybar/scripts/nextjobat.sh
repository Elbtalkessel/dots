#!/bin/sh

queue=`atq`
printf "RemindME: "
if [ ! -z "$queue" ]
then
  atq | sort | head -1 | awk '{print $5}'
else
   echo "None"
fi
