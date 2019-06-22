#!/usr/bin/env sh

export LD_LIBRARY_PATH=/usr/lib/

export LOCAL_SH="${HOME}/.local/sh"

export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_RUNTIME_DIR="${HOME}/.local/run"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"

export POLYBAR_HOME="${XDG_CONFIG_HOME}/polybar"

export GOPATH="${HOME}/.go"
export GOBIN="${GOPATH}/bin"
export GOBIN_SYS="/usr/local/go/bin"

export ARCH="x86_64"
export ARCHFLAGS="-arch x86_64"

export LANG="en_US.UTF-8"
export BROWSER="qutebrowser"
export EDITOR="nvim"
export VISUAL="nvim"

export PAGER="less"
export PERLDOC_PAGER="more"
export LESS="-g -i -M -R -S -w -K -z-4 --lesskey-file=${XDG_CONFIG_HOME}/lesskey"
export LESSHISTFILE="${XDG_CACHE_HOME}/.lesshst"
export GREP_COLORS="mt=30;43"

export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"
export WINEPREFIX="/home/risus/.steam/steam/steamapps/compatdata/8500/pfx"
export NO_AT_BRIDGE=1
export QT_STYLE_OVERRIDE="GTK+"

path.add ${LOCAL_SH}
path.add ${GOBIN}
path.add ${GOBIN_SYS}
path.add ${LOCAL_BIN}
path.add $(yarn global bin)

export XDG_RUNTIME_DIR=/run/user/`id -u`

# virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Projects
source /usr/local/bin/virtualenvwrapper_lazy.sh

export NVM_DIR="${HOME}/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
