# changes wallpaper every 10 mins from a repo of thousands of pics

while [ 7 -gt 6 ]
do
	nitrogen --random ~/Downloads/Media/Pictures/DUMP/ --set-auto --head=0
	nitrogen --random ~/Downloads/Media/Pictures/DUMP/ --set-auto --head=1
	sleep 600
done

