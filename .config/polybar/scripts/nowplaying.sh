#!/usr/bin/env bash

zscroll -u true -b "♪ x" -d 0.3 -M "mpc status" -m "playing" "-b ''" -m "paused" "-b '' -s false" "mpc current" &

wait
