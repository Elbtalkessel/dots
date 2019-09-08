#!/bin/env bash

# ...
profiles=$(ponymix list-profiles | grep -P "extra(1$|1 \[)|^output:analog-stere(o$|o \[)" | sed 's,-, ,g' | sed 's,output:,,' | awk '{print toupper($0)}')


MENU="$(rofi -dmenu -i -p 'Audio Profile' -theme themes/appsmenu.rasi <<< $profiles)"
case "$MENU" in
  *ANALOG*) pactl set-card-profile 0 output:analog-stereo ;;
  *HDMI*) pactl set-card-profile 0 output:hdmi-stereo-extra1
esac
