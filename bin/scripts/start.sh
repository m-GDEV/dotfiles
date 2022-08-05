#! /bin/bash
# script to start all my programs
HOST=$(uname -n)

redshift -x
pkill -f notify-osd
pkill -f brave
pkill pcloud
pkill polybar
pkill xfce4-power-manager
#pkill aw-qt
pkill nm-applet
pkill -f wall.sh
pkill -f twenty.sh
pkill -f syncthing

if [ $HOST == "PC" ]; then
    ~/bin/scripts/monitor-layout.sh
else
    echo
fi

unclutter & 
dunst & 
# aplay -f cd /dev/zero &
redshift -O 3300 &
syncthing &
/usr/bin/brave &
xfce4-power-manager &
aw-qt &
nm-applet &
~/bin/scripts/wall.sh &
~/bin/scripts/twenty.sh & 
~/bin/scripts/polybar/polybar.sh &
clear

