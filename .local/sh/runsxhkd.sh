#!/usr/bin/env sh
killall -q sxhkd
while pgrep sxhkd >/dev/null; do sleep 1; done
sxhkd &
