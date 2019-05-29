#!/bin/env sh

monitor1=eDP-1-1
monitor2=HDMI-1-2
hasMonitor2=$(xrandr | grep "${monitor2} connected")

if [ -n "$hasMonitor2" ]; then
  printf "${monitor2} right of ${monitor1} and is primary"
  xrandr --output ${monitor2} --right-of ${monitor1} --primary
fi

