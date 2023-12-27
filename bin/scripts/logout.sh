#!/bin/bash

# Simple script to handle logout screen
HOST=$(uname -n)
ERR="Programs not found"
LOCK_COMMAND="i3lock -p default -efi $HOME/Pictures/Wallpapers/elden-ring-malenia.png"

print_help() {
    echo -e "Usage: ./logout.sh <option>\n"
    echo -e "--dashboard\tShow oblogout menu"
    echo -e "--lock\t\tLock the screen with i3lock"
    echo -e "--logout\tLogout of current session"
    echo -e "--suspend\tLock and suspend system"
    echo -e "--reboot\tReboot system"
    echo -e "--shutdown\tShutdown system"
}

# Checking requirements
if ! command -v "oblogout" &> /dev/null || ! command -v "i3lock" &> /dev/null ; then
    echo "$ERR"
    notify-send "$ERR"
    exit -1
fi

# Default case, run logout program
if [ "$1" == "--dashboard" ]; then
    # Start and kill picom if on PC, this allows for nice animation when opening it
    if [ "$HOST" == "ENVY" ]; then
        oblogout
    else
        picom --no-vsync &
        oblogout
        sleep 1
        pkill -f picom
    fi

# Just logging out
elif [ "$1" == "--lock" ]; then
    exec $LOCK_COMMAND

# Logging out of current session
elif [ "$1" == "--logout" ]; then
    systemctl restart lightdm

# Suspend
elif [ "$1" == "--suspend" ]; then
    exec $LOCK_COMMAND & # Need to fork since exec is weird and doesnt let i3lock do it itself
    systemctl suspend

# Hibernate
elif [ "$1" == "--hibernate" ]; then
    exec $LOCK_COMMAND & # Need to fork since exec is weird and doesnt let i3lock do it itself
    systemctl hibernate

# reboot
elif [ "$1" == "--reboot" ]; then
    reboot

# Shutdown
elif [ "$1" == "--shutdown" ]; then
    shutdown now

elif [ "$1" == "--help" ]; then
    print_help
else
    echo "Cannot run by itself! Give me some options!";
    notify-send "Cannot run by itself! Give me some options!";
    print_help
fi
