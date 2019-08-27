#!/bin/bash

set -euo pipefail
if pgrep -x i3 >/dev/null; then
    /usr/bin/dunst
else
    /usr/bin/notify-send
fi
