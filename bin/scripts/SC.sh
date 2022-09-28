#! /bin/sh

# A script that allows user to cycle pause all instaces of mpv or choose which one to cycle pause individually

if [ "$1" == "-s" ]; then
    scrot 'screenshot_%Y%m%d_%H%M%S.png' -e 'mv $f ~/pCloudDrive/EXCLUDE/Pictures/screenshots/' && notify-send "Screenshot Taken!" $(date +%H:%M:%S)

else
	scrot 'screenshot_%Y%m%d_%H%M%S.png' -s -e 'mv $f ~/pCloudDrive/EXCLUDE/Pictures/screenshots/' && notify-send "Screenshot Taken!" $(date +%H:%M:%S)
fi

