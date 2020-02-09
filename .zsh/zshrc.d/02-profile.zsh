#!/usr/bin/env sh

export LD_LIBRARY_PATH=/usr/lib/

export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_RUNTIME_DIR="${HOME}/.local/run"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export MPD_SOCKET="${XDG_RUNTIME_DIR}/mpd.socket"
export DXVK_CONFIG_FILE="${XDG_CONFIG_HOME}/dxvk/dxvk.conf"

export GOROOT="${HOME}/.go"
export GOPATH="${HOME}/.local/bin"

export LANG="en_US.UTF-8"
export EDITOR="nvim"
export VISUAL="nvim"

export PAGER="less"
export PERLDOC_PAGER="more"
export LESS="-g -i -M -R -S -w -K -z-4 --lesskey-file=${XDG_CONFIG_HOME}/lesskey"
export LESSHISTFILE="${XDG_CACHE_HOME}/.lesshst"
export GREP_COLORS="mt=30;43"

export BROWSER=/usr/bin/qutebrowser

export KUBECONFIG=~/.kube/kind-config-kind

export MOUNT_ROOT=~/mnt

path.add "${HOME}/.local/bin"
path.add "${HOME}/.yarn/bin"
path.add "${HOME}/.local/sh"
path.add "/snap/bin"
path.add "$GOROOT/bin"

# virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Projects
export VIRTUALENVWRAPPER_PYTHON=`which python3`
source `which virtualenvwrapper_lazy.sh`

