#!/bin/bash

# script to start all my programs
# --- In the future i should make a config file this script reads from where each
# line has the following info: [program name] - [universal, pc, or laptop]
# that way i read them all once and use functions instead of hardcoding them
# like i am below ---
# --- If you're making changes, check if every program is installed before running
# if they all arent tell the user ---
# use this: https://chat.openai.com/share/1409859e-1659-44b4-9aa2-f14440df95ba
HOST=$(uname -n)

# Kill all programs (this is only important if restarting i3 for example)
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
pkill -f 'screen-brightness.py'
pkill -f parcellite
pkill -f beeper
pkill -f onboard
pkill -f 'sound.sh'
# pkill -f autotiling
pkill -f mate-polkit
pkill -f xedgewarp

# Programs to start on any device
unclutter &
numlockx &
dunst &
/usr/lib/geoclue-2.0/demos/agent &
redshift-gtk &
syncthing &
firefox &
xfce4-power-manager &
nm-applet &
~/bin/scripts/wall.sh &
~/bin/scripts/polybar/polybar.sh &
aw-qt &
parcellite &
beeper &
# autotiling &
/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
~/bin/scripts/i3-organize &

# Programs to start only on a PC
if [ $HOST == "PC" ]; then
    spotify &
    # picom --no-vsync &
    xfce4-taskmanager &
    # steam &
    # lutris &
    ~/bin/scripts/screen-brightness.py &
    ~/bin/scripts/sound.sh &
    systemctl --user start nfancurve.service &
    xedgewarp &

# Programs to start only on my laptop
elif [ $HOST == "ENVY" ]; then
    # picom --vsync &
    onboard &
fi


clear

