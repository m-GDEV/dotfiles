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


unclutter &
numlockx &
dunst &
# aplay -f cd /dev/zero &
/usr/lib/geoclue-2.0/demos/agent &
redshift-gtk &
syncthing &
/usr/bin/brave &
spotify &
xfce4-power-manager &
nm-applet &
~/bin/scripts/wall.sh &
~/bin/scripts/polybar/polybar.sh &
aw-qt &
# picom --backend glx &

if [ $HOST == "PC" ]; then
    # xrandr --output DP-4 --mode 1920x1080 --rate 180.00
    xfce4-taskmanager &
    steam &
    heroic &
    ~/bin/scripts/sound.sh &
else
    echo
fi


clear

