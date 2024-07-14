#! /bin/bash

set -e

# Returns temp in milicelcius or some shit, so divide by 1000
CPUTEMP=$(cat /sys/class/thermal/thermal_zone0/temp /sys/class/thermal/thermal_zone1/temp | tail -1)
CPUTEMP=$(( CPUTEMP / 1000 ))

if [ $CPUTEMP -gt 70 ]; then
    # notify-send "high cpu temps!"
    :
elif [ $CPUTEMP -gt 80 ]; then
    notify-send "high cpu temps!"
    # 70 is optimal. 80 is expected. 90 is cause for concern. 100 is "oh no"
fi

# Show gpu temps if on PC
if [ "$(hostname)" == "PC" ]; then
    GPUTEMP=$(nvidia-smi | sed -n 10p | awk '{print $3}' | cut -c 1-2)
    if [ $GPUTEMP -gt 70 ]; then
        # notify-send "high gpu temps!"
        :
    elif [ $GPUTEMP -gt 80 ]; then
        notify-send "expected gpu temps!"
    elif [ $GPUTEMP -gt 90 ]; then
        notify-send "concern gpu temps!"
    elif [ $GPUTEMP -gt 100 ]; then
        notify-send "FUCKKK gpu temps!"
    fi

    echo "🖥️ $CPUTEMP°C : 🎨 $GPUTEMP°C"

# Only show cpu temps if on ENVY
else
    echo "🌡️ $CPUTEMP°C"
fi

