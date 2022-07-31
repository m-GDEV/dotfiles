BAT_STAT=$(find /sys/class/power_supply/BAT*)

# if there is no battery, echo nothing
if [ -z $BAT_STAT ]; then
   echo -n
else  
    echo "🔋 $(acpi command | head -1 | awk '{ print $4 }' | cut -c 1-3) |"
fi

