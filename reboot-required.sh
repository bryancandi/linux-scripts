#!/bin/bash

FILE="/var/run/reboot-required"

if [ -f "$FILE" ]; then
    echo "A reboot is required for the following packages:"
    cat /var/run/reboot-required.pkgs
else
    echo "No reboot is required at this time."
fi
