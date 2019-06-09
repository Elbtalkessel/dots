function zsh-colors {
  for code in {000..255}; do
    print -P -- "$code: %F{$code}Test%f";
  done
}

function icons {
  case "$1" in
    *copy) printf "\u$2" | xclip ;;
    *icomoon) xfd -fa "icomoon\-feather" & ;;
    *) echo "icons <copy|icomoon>"
  esac
}

function proc.who {
  if [ -z $1 ]
  then
    echo "usage: proc.who <user|pid|command>"
    return 2
  fi
  local fsc=`echo $1 | cut -c1-1`
  local rsc=`echo $1 | cut -c2-`
  local val=$(ps -eo user,pid,comm | grep -P "^USER|[$fsc]$rsc" --color=none)
  echo $val
  if [ "$2" = '-c' ]
  then
    echo $val | awk "NR==2" | grep -Po "\d+" | xclip -selection clipboard
    echo "PID copied"
  fi
}
