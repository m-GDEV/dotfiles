# set -xv

BAT_STAT=$(find /sys/class/power_supply/BAT* 2> /dev/null)

# if there is no battery, echo nothing
if [ -z $BAT_STAT ]; then
    echo -n
else
    STATUS=$(acpi command | head -1 | awk '{ print $3 }')
    BATTERY_LEVEL=$(acpi command | head -1 | awk '{ print $4 }' | cut -c 1-3)

    if [ "$STATUS" = "Charging," ]; then
        TIME_TO_FULL=$(upower -d | grep -i 'time to full' | head -1 | awk '{print $4" "$5}')
        echo "⚡️ $BATTERY_LEVEL ($TIME_TO_FULL) |"
    else
        TIME_TO_EMPTY=$(upower -d | grep -i 'time to empty' | head -1 | awk '{print $4" "$5}')
        echo "🔋 $BATTERY_LEVEL ($TIME_TO_EMPTY) |"
    fi
fi

