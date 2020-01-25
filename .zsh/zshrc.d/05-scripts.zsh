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


strjoin() {
    IFS=$1
    shift
    echo "$*"
}


mo() {
    local mount_to=`strjoin / $MOUNT_ROOT $@`
    mkdir -p "$mount_to"

    if [ $# -eq 2 ]; then
        local mount_from="$1:/$2/"
        sshfs $mount_from $mount_to
    else
        local mount_from="/dev/$1"
        sudo mount $mount_from $mount_to
    fi
    
    if [ $? -ne 0 ]; then
        rm -rv "$MOUNT_ROOT/$1"
        printf 'tried: '
    fi
    echo "$mount_from -> $mount_to"
}

um() {
    local umount_from=`strjoin / $MOUNT_ROOT $@`
    sudo umount $umount_from
}

prj() {
    local PROJECT_DIR=~/Projects
    if [ -z $1 ]; then
        ls $PROJECT_DIR
    else
        local TARGET=`ls $PROJECT_DIR | grep $1`
        cd "${PROJECT_DIR}/${TARGET}"
        workon $TARGET || source .venv/bin/activate || source env/bin/activate || true
    fi
}
compctl -W ~/Projects -/ prj
 

copy() {
    printf $1 | xclip -selection clipboard
    notify-send "Clipboard: $1"
}

rzathura() {
    zathura "$@" &
}

rfeh() {
    feh "$@" &
}

togglemem() {
    local min=67584
    local max=1048576
	local current=`cat /proc/sys/vm/min_free_kbytes`
	if [ "$current" -gt "$min" ]; then
		local target=$min
	else
		local target=$max
	fi
	echo "Set $target kb of free vm mem"
    echo $target | sudo tee /proc/sys/vm/min_free_kbytes
}
