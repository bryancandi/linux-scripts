#!/bin/bash
# Shell script for Linux Mint (or other distros with Cinnamon Desktop Environment)
# Script by Bryan Candiliere - 2025
#
# Cinnamon doesn't have a configurable screen timeout for the lock screen, 
# so it follows the main screen inactivity timeout.
# This allows you to change the timeout after locking/sleeping the display,
# then change back to a longer timeout after unlocking.
# The script can be executed by a keyboard shortcut in Cinnamon, such as Super+L.

# Enable screensaver and lock display
cinnamon-screensaver-command -l

# Put monitor to sleep
xset dpms force off

# Change sleep delay while screen is off in case of accidental wakeup (from mouse?)
# Values are in seconds
gsettings set org.cinnamon.settings-daemon.plugins.power sleep-display-ac 20

# Wait for user to unlock the screen
dbus-monitor --session "interface='org.cinnamon.ScreenSaver', member='ActiveChanged'" |
while read -r line; do
    if echo "$line" | grep -q "boolean false"; then
        # Change sleep delay back to 5 minutes (300 seconds)
        gsettings set org.cinnamon.settings-daemon.plugins.power sleep-display-ac 300

        # Terminate dbus-monitor after handling unlock event
        pkill -f "dbus-monitor"
        
        # Break to ensure script exits cleanly
        break
    fi
done

