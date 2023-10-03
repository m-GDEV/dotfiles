#!/bin/bash
#
# volume.sh - A script to adjust the volume with amixer and send notifications using notify-send

# Check if notify-send is installed
if ! command -v notify-send &> /dev/null; then
    echo "Error: notify-send is not installed. Please install it to use this script."
    exit 1
fi

# Check if amixer is installed
if ! command -v amixer &> /dev/null; then
    notify-send "Error: amixer is not installed. Please install it to use this script." "❌"
    exit 1
fi

# Check if no options are provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 [-I] [-D] [-M] [-U]"
    exit 1
fi

# Function to get the current soft volume level
get_current_volume() {
    amixer -D pulse get Master | sed -n 6p | grep -o '\[[0-9]*%\]' | cut -c 2- | rev | cut -c 3- | rev
}

# Main script
while getopts "IDMU" option; do

    case $option in
        I) # Increase volume
            pactl -- set-sink-volume 0 "+5%"
            notify-send "🔊 Volume Increased to $(get_current_volume)%"
            ;;

        D) # Decrease volume
            pactl -- set-sink-volume 0 "-5%"
            notify-send "🔉 Volume Decreased to $(get_current_volume)%"
            ;;
        *)
            echo "Usage: $0 [-I] [-D] [-M] [-U]"
            exit 1
            ;;
    esac
done

