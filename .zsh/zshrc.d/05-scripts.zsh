#!/bin/zsh


iptobin() {
    ip=""
    for decimal in `echo ${1} | tr '.' ' '`; do
        converted=`bc <<< "obase=2;$decimal"`
        padded=`printf '%08d' $converted`
        if [ ! -z "$ip" ]; then
            padded=" $padded"
        fi
        ip="${ip}${padded}"
    done
    echo $ip
}


nvm() {
    if [ -z "$NVM_DIR" ]; then
        export NVM_DIR="${HOME}/.nvm"
        \. "$NVM_DIR/nvm.sh"
    fi
    nvm $@
}


colors() {
  for code in {000..255}; do
    print -P -- "$code: %F{$code}Test%f";
  done
}


icons() {
  case "$1" in
    *copy) printf "\u$2" | xclip ;;
    *icomoon) xfd -fa "icomoon\-feather" & ;;
    *) echo "icons <copy|icomoon>"
  esac
}


proc() {
  if [ -z $1 ]
  then
    echo "usage: proc <user|pid|command>"
    return 2
  fi
  local fsc=`echo $1 | cut -c1-1`
  local rsc=`echo $1 | cut -c2-`
  local val=$(ps -eo user,pid,comm | grep -P -i "^USER|[$fsc]$rsc" --color=none)
  echo $val
  if [ "$2" = '-c' ]
  then
    local pid=`echo $val | awk "NR==2" | grep -Po "\d+" | tr -d '\n'`
    echo pid | xclip -selection clipboard
    echo "$pid copied"
  fi
}


mo() {
    sudo mkdir -p "/mnt/$1"
    sudo mount "/dev/$1" "/mnt/$1"
}

um() {
    sudo umount "/mnt/$1"
}

prj() {
    local PROJECT_DIR=~/Projects
    if [ -z $1 ]; then
        ls $PROJECT_DIR
    else
        local TARGET=`ls $PROJECT_DIR | grep $1`
        workon $TARGET || true
        cd "${PROJECT_DIR}/${TARGET}"
    fi
}
compctl -W ~/Projects -/ prj
 
