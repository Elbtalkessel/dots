#!/usr/bin/env sh

alias quit="exit"

alias S="sudo systemctl"
alias s="sudo"
alias .="source"
alias fep="feh ${HOME}/Pictures"
alias t="touch"

alias externalip="curl ipinfo.io/ip"
alias mpc="mpc --host $MPD_SOCKET"

alias wgdown="sudo wg-quick down wg0"
alias wgup="sudo wg-quick up wg0"
alias wgre="wg.down && wg.up"
alias postg="sudo -u postgres -i"

alias music='ncmpcpp -b $XDG_CONFIG_HOME/ncmpcpp/bindings'
alias mail='neomutt'
alias jabber='profanity'
alias kimai='kimai2-cmd'

alias dfh="df -h | grep -P \"^File|sd\" --color=never | awk 'NR<2{print \$0;next}{print \$0 | \"sort\"}'"

alias vim="nvim"
alias vi="nvim"
alias sudo="sudo"
alias reboot="sudo reboot"
alias poweroff="sudo poweroff"
alias halt="sudo halt"

alias grepr="grep -r"
alias egrepr="egrep -r"

alias mv="mv -v"
alias ln="ln -v"
alias cp="cp -v"
alias rm="rm -v"
alias ls="ls --group-directories-first --dereference-command-line-symlink-to-dir --color=auto"
alias ll="ls --dereference-command-line-symlink-to-dir -lh"
alias l="ls -la --dereference-command-line-symlink-to-dir"
alias info='info --vi-keys --init-file=${XDG_CONFIG_HOME}/infokey'
alias pgrep="pgrep -l"
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias grip="grep -i --color=auto"

alias nodejs="node"

alias rcopy="rsync -rv --info=progress2 --ignore-existing"
alias mosrv="sudo sshfs -o allow_other,IdentityFile=~/.ssh/id_rsa risus@192.168.43.232:/ /mnt/server"

# vim:ft=sh
