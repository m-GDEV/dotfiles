DIR="/home/musa/Downloads/Media/Pictures/DUMP"
IMG=$(ls ~/Downloads/Media/Pictures/DUMP/ | sort -R | sed -n 11p)

nitrogen --set-auto --head=0 $DIR/$IMG
nitrogen --set-auto --head=1 $DIR/$IMG
