#!/bin/bash

rofi_command="rofi -theme themes/scrotmenu.rasi"

### Options ###
screen=""
area=""
window=""
# Variable passed to rofi
options="$screen\n$area\n$window"

function _scrot() {
    local prefix=$(date +"%y_%m_%d_%H_%M_%S")
    local fname="${prefix}.png"

    scrot $fname -e 'xclip -selection clipboard -t "image/png" < $f' $@
    mv $fname ~/Pictures/Screenshots
}

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 1)"
case $chosen in
    $screen)
        sleep 1; _scrot
        ;;
    $area)
        _scrot -s
        ;;
    $window)
        sleep 10; _scrot -u
        ;;
esac

