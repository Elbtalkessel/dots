function unicode {
  printf "%b\n" "\U$(printf "%6s\n" "$1" | tr ' ' 0)"
}

function field {
  tr -s ' ' | cut -d ${2:- } -f $1
}

function proc {
  ps wwwaux | egrep --color=always "($1|%CPU)" | grep -v grep
}


function find-byname {
  find ${2:-.} -name "*${1}*"
}

# List processes with most files open
function list-open-files {
  lsof | field 2 | uniq -c | sort -rn | head
}

function list-top-fsize {
  test -e ${1:-.} && ls -1RhsQ ${1:-.}/* \
    | sed -e "s/^ *//" \
    | grep "^[0-9]" \
    | sort -rh \
    | head -${2-10} \
    | sed 's/[^ ]*/\o033[36;1m\0\o033[0m/' \
    | xargs printf "%20s │ %s\n"
}


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

function show {
  nohup nautilus $1 &
}
