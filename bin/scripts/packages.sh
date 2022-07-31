#! /bin/bash
CHG=0

while [ 7 -gt 6 ]
do
	INIT="$(pacman -Q | wc -l)"
	echo "$INIT + $CHG"
	sleep 100
	CHG="$(pacman -Q | wc -l)"
	CHG=$((CHG-INIT))

done
