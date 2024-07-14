#! /bin/sh

# A script that allows user to cycle pause all instaces of mpv or choose which one to cycle pause individually
# Added maim functionality on Dec 29, 2023
# Compression level is higher if selecting since less of the screen is captured so we don't need to compress
# as much to save a good amount of space

if ! command -v maim || ! command -v flameshot; then
    notify-send "Maim or flameshot not installed!"
    exit 1
fi

if [ "$1" == "-s" ]; then
    # fullscreen picture
    maim -m 8 -f jpg > "$HOME/pCloudDrive/EXCLUDE/Pictures/screenshots/screenshot_$(date +%Y%m%d_%H%M%S).jpg" && notify-send "Screenshot Taken!" $(date +%H:%M:%S)
elif [ "$1" == "-f" ]; then
    flameshot gui --path "$HOME/pCloudDrive/EXCLUDE/Pictures/screenshots"
else
    # selected part of screen
    maim -m 9 -f jpg -s > "$HOME/pCloudDrive/EXCLUDE/Pictures/screenshots/screenshot_$(date +%Y%m%d_%H%M%S).jpg" && notify-send "Screenshot Taken!" $(date +%H:%M:%S)
fi


