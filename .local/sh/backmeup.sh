#!/usr/bin/env sh


backup() {
  local DIR="/tmp/sheback/$(date +%Y%m%d%H%M%S)"
  mkdir -p $DIR

  while read f
  do
    if [ -f "$f" ]
    then
      cp -v $f ${DIR}/
    elif [ -z "$f" ]
    then
      break
    else
      echo "$f not a file"
    fi
  done
}

backup $@
