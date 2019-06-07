#!/usr/bin/env sh

alias quit="exit"

alias S="sudo systemctl"
alias s="sudo"
alias .="source"
alias fep="feh ${HOME}/Pictures"

alias externalip="curl -s checkip.dyndns.org | sed 's/[^0-9.]//g'"

alias term.polybar='killall polybar'
alias termkill.polybar='killall -9 polybar'

alias ed.i3="vi ${XDG_CONFIG_HOME}/i3/config"
alias ed.polybar="vi ${POLYBAR_HOME}/config.ini"
alias ed.profile="vi ~/.profile"
alias ed.vimrc="vi ~/.vim/vimrc"
alias ed.xres="vi ~/.Xresources"
alias ed.aliases="vi ~/.zsh/zshrc.d/20-aliases.zsh && re.aliases"

alias wg.down="sudo wg-quick down wg0"
alias wg.up="sudo wg-quick up wg0"

alias go.sh='cd $LOCAL_SH'
alias go.music="cd $MUSIC"
alias go.backups='cd $BACKUPS'
alias go.vault='cd $VAULT'
alias go.polybar="cd $POLYBAR_HOME"
alias go.projects="cd ${HOME}/Projects"

alias re.aliases="source ~/.zsh/zshrc.d/20-aliases.zsh"
alias re.xresources="xrdb ~/.Xresources"

alias ex.music='ncmpcpp -b $XDG_CONFIG_HOME/ncmpcpp/bindings'
alias ex.mail='neomutt'
alias ex.jabber='profanity'

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
alias grep="grep -i --color=auto"
alias egrep="egrep --color=auto"

alias adb="sudo adb"

alias nodejs="node"

# vim:ft=sh
