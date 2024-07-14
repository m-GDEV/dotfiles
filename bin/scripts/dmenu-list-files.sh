#!/bin/bash

# $1 is directory
# $2 is filetype

if [ ! -z "$1" ]; then
    dir="$1"
else
    notify-send "You didn't specify a dir, you probably should."
    dir="/"
fi

if [ ! -z "$2" ]; then
    filetype=".$2"
else
    filetype=""
fi


find "$dir" -type f -iname "*$filetype" | sort | \
    dmenu -i -p "Select $filetype:" -nb '#3A0754' -sb '#450E74' | \
    xargs -I{} zathura "{}"
