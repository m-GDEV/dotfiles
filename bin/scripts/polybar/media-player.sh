#!/bin/bash

# Simple script that determines what my polybar music module prints
# If spotify is playing it prints each lyric, if not then it prints
# last sources title

# Redirects stderr to the variable as well
STATUS=$(playerctl -p spotify status 2>&1)
# echo $STATUS

# Check if programs installed
if ! command -v "playerctl" &> /dev/null && ! command -v "sptlrx" &> /dev/null ; then
    echo "Proper programs not installed!"
    exit
fi

# Kinda fixes race condition, fixlater idc
# if [ -z "$(ps aux | grep -v 'grep' | grep 'media-player.sh' )" ]; then
#     sptlrx pipe >> /tmp/lyrics &
# fi

# Check if pipe is running
if [ -z "$(ps aux | grep -v 'grep' | grep 'sptlrx pipe' )" ]; then
    sptlrx pipe >> /tmp/lyrics &
fi

# Script's logic
if [ "$STATUS" == "Paused" ] || ! playerctl -l | grep -q 'spotify' ; then
    # if [ "$STATUS" == "Paused" ]; then
    echo -n "$(playerctl metadata title | cut -c -50)"
elif [ "$STATUS" == "Playing" ]; then
    echo -n "$(tail -1 /tmp/lyrics)"
else
    echo "Nothing playing"
fi

