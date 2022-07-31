#! /bin/bash
export NETWORK=$(ip a | sed -n 7p | awk '{ print $2 }' | rev | cut -c 2- | rev)

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    export MONITOR=$m 
    polybar --reload simple 2> /dev/null &
  done
else
  polybar --reload simple &
fi
