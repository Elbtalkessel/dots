#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar -u 1000 >/dev/null; do sleep 1; done

polybar -c ~/.config/polybar/config.ini main &
