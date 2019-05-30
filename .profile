#!/usr/bin/env sh
#
# Defines runtime environment
#
export LD_LIBRARY_PATH=/usr/lib/

export LOCAL_ETC="${HOME}/.local/etc"
export LOCAL_BIN="${HOME}/.local/bin"
export LOCAL_LIB="${HOME}/.local/lib"
export LOCAL_SRC="${HOME}/.local/src"
export LOCAL_VAR="${HOME}/.local/var"
export LOCAL_SH="${HOME}/.local/sh"

export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_RUNTIME_DIR="${HOME}/.local/run"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"

export POLYBAR_HOME="${XDG_CONFIG_HOME}/polybar"

export GOPATH="${HOME}/.go"
export GOBIN="${GOPATH}/bin"
export GOBIN_SYS="/usr/local/go/bin"

export MUSIC="${HOME}/Music"
export WALLPAPERS="${HOME}/Pictures"
export BACKUPS="/mnt/1EACD264ACD235CD/Backups"
export VAULT="/media/risus/Secure"

export ARCH="x86_64"
export ARCHFLAGS="-arch x86_64"

export LANG="en_US.UTF-8"
export BROWSER="google-chrome"
export EDITOR="nvim"
export VISUAL="nvim"

export PAGER="less"
export PERLDOC_PAGER="more"
export LESS="-g -i -M -R -S -w -K -z-4 --lesskey-file=${XDG_CONFIG_HOME}/lesskey"
export LESSHISTFILE="${XDG_CACHE_HOME}/.lesshst"
export GREP_COLORS="mt=30;43"

export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"
export WINEPREFIX="${XDG_DATA_HOME}/wine"
export NO_AT_BRIDGE=1
export QT_STYLE_OVERRIDE="GTK+"


# Update PATH
path_prepend() {
  case ":$PATH:" in
    *":$1:"*) return ;; # already added
    *) PATH="$1:$PATH";;
  esac
}

path_prepend ${LOCAL_SH}
path_prepend ${GOBIN}
path_prepend ${GOBIN_SYS}


unset dir
unset -f path_prepend

export PATH=$PATH

export XDG_RUNTIME_DIR=/run/user/`id -u`

