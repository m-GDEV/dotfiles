#! /bin/sh

#set -xv

# A script that allows user to cycle pause all instaces of mpv or choose which one to cycle pause individually

if [ "$1" == "-a" ]; then

	# PAUSE ALL	
	FILES=$(ls /tmp/mpv-*)
	
	for f in $FILES
	do
		echo 'cycle pause' | socat - $f
	done

else
	# PAUSE INDIVIDUALLY
	SONG=$(ls /tmp/mpv-* | dmenu -i -l 10 -p "Song:") 
	ACTION=$(echo -e "cycle pause\nplaylist-next\nplaylist-prev" | dmenu -i -l 10 -p "Action:")
	
	echo "${ACTION}"   | socat - "$SONG"
fi
