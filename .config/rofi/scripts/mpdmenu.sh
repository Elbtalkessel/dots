#!/bin/bash

rofi_command="rofi -theme themes/mpdmenu.rasi"
function _mpc() {
    mpc --host ~/.local/run/mpd.socket $@
}

### Options ###
# Gets the current status of mpd (for us to parse it later on)
status="$(_mpc status)"
# Defines the Play / Pause option content
if [[ $status == *"[playing]"* ]]; then
    play_pause=""
else
    play_pause=""
fi
active=""
urgent=""
# Playlist menu
tog_pl=""
# Display if random mode is on / off
tog_random=""
if [[ $status == *"random: on"* ]]; then
    [ -n "$active" ] && active+=",5" || active="-a 5"
elif [[ $status == *"random: off"* ]]; then
    [ -n "$urgent" ] && urgent+=",5" || urgent="-u 5"
else
    tog_random=" Parsing error"
fi
stop=""
next=""
previous=""
# Variable passed to rofi
options="$previous\n$play_pause\n$stop\n$next\n$tog_random\n$tog_pl"

# Get the current playing song
current=$(_mpc current)
# If mpd isn't running it will return an empty string, we don't want to display that
if [[ -z "$current" ]]; then
    current="-"
fi

# Spawn the mpd menu with the "Play / Pause" entry selected by default
chosen="$(echo -e "$options" | $rofi_command -p "$current" -dmenu $active $urgent -selected-row 1)"
case $chosen in
    $previous)
        _mpc -q prev
        ;;
    $play_pause)
        _mpc -q toggle
        ;;
    $stop)
        _mpc -q stop
        ;;
    $next)
        _mpc -q next
        ;;
    $tog_pl)
        ~/.config/rofi/scripts/mpdpl.py
        ;;
    $tog_random)
        _mpc -q random
        ;;
esac

