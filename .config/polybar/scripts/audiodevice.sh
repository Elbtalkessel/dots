#!/bin/env bash

MENU="$(rofi -sep "|" -dmenu -i -p 'Audio Out' -location 3 -xoffset -200% -yoffset 30 -width 10 -hide-scrollbar -line-padding 5 -padding 5 -lines 2 <<< "Headphone|HDMI")"
case "$MENU" in
  *Headphone) pactl set-card-profile 0 output:analog-stereo ;;
  *HDMI) pactl set-card-profile 0 output:hdmi-stereo-extra1
esac
