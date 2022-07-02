#!/bin/bash

# simple shell script alternative to twenty_20.py
# this tells you to look around every 20 mins


SOUND="$HOME/Downloads/Media/Audio/zMisc./Sound-Effects/THUNDER.mp3"

while [ 7 -gt 6 ]
do
	if [ "$(date +%H)" -gt 23 ] || [ "$(date +%H)" -lt 9 ]; then
		echo "D"
		sleep 1200
	else
		VOL=$(amixer -R | sed -n 7p | cut -f7 -d" " | cut -c 2- | rev | cut -c 3- | rev)
		amixer set 'Master' 50%
		notify-send "Look Around!"
		play -q $SOUND
		amixer set 'Master' "$VOL%"
		sleep 20
		amixer set 'Master' 50%
		play -q $SOUND
		amixer set 'Master' "$VOL%"
		sleep 1200
	fi
done

