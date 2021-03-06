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

# lazy nvm load because I don't need it in my shell always
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
        deactivate > /dev/null 2>&1
        if [ -d ~/.virtualenvs/$TARGET ]; then
            workon $TARGET
        elif [ -f Pipfile ]; then
            pipenv shell
        fi
    fi
}
compctl -W ~/Projects -/ prj


arcprj() {
    local PROJECT_DIR=~/Projects
    local PROJECT_ARC="${PROJECT_DIR}/archives"
    if [ -z $1 ]; then
        ls $PROJECT_DIR
    else
        tar -zcvf "${PROJECT_ARC}/$1.tgz" "$1"
        if [ $? -eq 0 ]; then
            echo "DELETE $PROJECT_DIR/$1? (y/n)"
            read del
            if [ "$del" = "y" ]; then
                rm -vrf "$PROJECT_DIR/$1"
            fi
        fi
    fi
}
compctl -W ~/Projects -/ arcprj


darcprj() {
    local PROJECT_DIR=~/Projects
    local PROJECT_ARC="${PROJECT_DIR}/archives"
    if [ -z $1 ]; then
        ls $PROJECT_ARC
    else
        if [ ! -z "$1" ]; then
            tar -zxvf "$PROJECT_ARC/$1.tgz" "${PROJECT_DIR}/$1"
            if [ $? -eq 0 ]; then
                rm -rf "${TARGET}"
            fi
        fi
    fi
}



lfcd() {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

pipi() {
    pip install $@
    required=$(echo $@ | tr ' ' '\n' | grep -vP '^-')
    # better grep from output of previous command but whatever, next time
    installed=$(pip freeze | grep $required)
    while IFS= read -r req
    do
        # req package name
        # ins package name and its version
        ins=$(echo "$installed" | grep "$req")
        echo $ins $req
        if [ ! -z "$ins" ]; then
            # is required package already in requirements?
            grep -q "$req" requirements.txt
            if [ $? -eq 1 ]; then
                echo "add $ins"
                echo "$ins" >> requirements.txt
            else
                echo "upd $ins"
                sed -i "s,$req.*,$ins," requirements.txt
            fi
        fi
    done <<< "$required"
}

pipr() {
    pip uninstall $@
    pkgs=$(echo $@ | tr ' ' '\n' | grep -vP '^-')
    while IFS= read -r line
    do
        echo "del $line"
        sed -i "s,$line.*,," requirements.txt
    done <<< "$pkgs"
}

vboxsetresolution() {
    MACHINE=$(vboxmanage list vms | grep -o '".*"' | grep -o '[^"]*' | dmenu)
    RESOLUTION=$(xrandr | grep -o "connected primary [^+]*" | grep -Po '[[:digit:]]*x[[:digit:]]*')
    vboxmanage setextradata "$MACHINE" VBoxInternal2/EfiGraphicsResolution $RESOLUTION
    echo "Set $MACHINE to $RESOLUTION"
}



countdown()
(
  IFS=:
  set -- $*
  secs=$(( ${1#0} ))
  while [ $secs -gt 0 ]
  do
    sleep 1 &
    printf "\rT-Minus %02d" $((secs%60))
    secs=$(( $secs - 1 ))
    wait
  done
  printf "\rTakeoff 00\n"
)
