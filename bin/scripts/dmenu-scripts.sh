#!/bin/bash

# This program opens a dmenu that lets the user select which script they want
# It also passes all command line argument along

# Script should be run like this:
# /dmenu-scripts.sh '. py'
# MAKE SURE TO QUOTE ARGS BEING PASSED

dir="$HOME/bin/scripts"
#
# scripts=$(find "$dir" -type f -iname "dmenu*")
# # You can probably figure out what this does its simple. I like regex lol
# # Assumes scripts of this format:
# # 1. Inside $dir
# # 2. dmenu-(script_name).sh
# # This will strip out everything but script_name to make it nice to look at
# script_names=$(find "$dir" -type f -iname "dmenu*" | sed -r 's/^.*dmenu-(.*)\.sh/\1/g')
#
# echo "$script_names" | dmenu -i -p "Select pdf:" -nb '#3A0754' -sb '#450E74' | xargs -I{} -t sh -c "$dir/dmenu-{}.sh $@"
#
# OK i wrote this whole thing but it won't work cus i can't pass command line args to the individual
# scripts while also only calling this script with one keybind in i3
# Here's my new solution

scripts="dmenu-list-files.sh $HOME/Winter 2024 pdf
manpdf"

echo "$scripts" | dmenu -i -p "Select scripts:" -nb '#3A0754' -sb '#450E74' | xargs -I{} -t sh -c "$dir/{}"
# fuck this im tired, do it later
