#!/usr/bin/env bash

if [[ -z `ifconfig | grep "wg0"` ]]; then
    echo "VPN down"
else
    echo "VPN up"
fi