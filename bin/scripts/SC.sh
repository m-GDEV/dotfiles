scrot 'screenshot_%Y%m%d_%H%M%S.png' -se 'mv $f ~/pCloudDrive/EXCLUDE/Pictures/screenshots/'

notify-send "Screenshot Taken!" $(date +%H:%M:%S)

