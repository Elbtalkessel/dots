#/bin/sh


unset_switch_to_app() {
    for i in {1..9}; do
        gsettings set "org.gnome.shell.keybindings" "switch-to-application-$i" "[]"
    done
}

fix_ssh_perms() {
    chmod 700 ~/.ssh
    cd ~/.ssh
    chmod 644 authorized_keys known_hosts config
    chmod 644 ~/.ssh/*.pub
    chmod 600 ~/.ssh/*_rsa
    chmod 400 ~/.ssh/*.pem
    cd -
}

"$@"
