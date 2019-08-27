#/bin/sh


function unset_switch_to_app() {
    for i in {1..9}; do
        gsettings set "org.gnome.shell.keybindings" "switch-to-application-$i" "[]"
    done
}

"$@"
