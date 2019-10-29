pkill dunst
dunst -config ~/.config/dunst/dunstrc &

notify-send -u critical "Critical" "critical message"
notify-send -u normal "Noramal" "normal message"
notify-send -u low "Low" "low message"
notify-send -u normal "42cc@khavr.com" "should be ignored"
