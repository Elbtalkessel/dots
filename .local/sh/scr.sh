#!/usr/bin/env sh

scrot -e 'xclip -selection clipboard -t "image/png" < $f'
mv *_scrot.png ${HOME}/Pictures/Screenshots 2>&1 > /dev/null

