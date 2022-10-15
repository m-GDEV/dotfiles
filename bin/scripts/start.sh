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
pkill -f syncthing
pkill -f numlockx
pkill -f picom

# if [ $HOST == "PC" ]; then
#     ~/bin/scripts/monitor-layout.sh
# else
#     echo
# fi

unclutter & 
numlockx &
dunst & 
# aplay -f cd /dev/zero &
redshift -O 3300 &
syncthing &
/usr/bin/brave &
xfce4-power-manager &
nm-applet &
~/bin/scripts/wall.sh &
~/bin/scripts/polybar/polybar.sh &
aw-qt &
picom --experimental-backends --backend glx &
clear

