# set -xv

BAT_STAT=$(find /sys/class/power_supply/BAT* 2> /dev/null)

# if there is no battery, echo nothing
if [ -z $BAT_STAT ]; then
    echo -n
else
    STATUS=$(acpi command | head -1 | awk '{ print $3 }')
    BATTERY_LEVEL=$(acpi command | head -1 | awk '{ print $4 }' | cut -c 1-3)

    if [ "$STATUS" = "Charging," ]; then
        echo "⚡️ $BATTERY_LEVEL |"
    else
        echo "🔋 $BATTERY_LEVEL |"
    fi
fi

