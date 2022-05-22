#! /bin/bash
# script to start all my programs

redshift -x
pkill -f notify-osd
pkill -f brave
pkill pcloud
pkill polybar
pkill xfce4-power-manager
pkill aw-qt
pkill nm-applet
pkill -f wall.sh
pkill -f twenty.sh

unclutter & 
dunst & 
#picom &
aplay -f cd /dev/zero &
redshift -O 3300 &
/usr/bin/brave &
/home/musa/Downloads/APPS/AppImage/pcloud &
polybar -r simple &
polybar -r simple2 & 
xfce4-power-manager &
/home/musa/Downloads/APPS/Uncompressed/activitywatch/aw-qt &
nm-applet &
~/bin/scripts/wall.sh &
~/bin/scripts/twenty.sh & 
clear

