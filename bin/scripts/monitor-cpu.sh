#! /bin/bash

# Script to monitor cpu usage.
# 1: While true, the script will print the cpu usage and temp
# 2: It calculates the max and min points of the cpu's temp while the script has been running
# 3: It finds the average temp & cpu usage

rm /tmp/cpu.log
START=$(date)
SECS=$(date +%s)
# set -xv

while [ 7 -gt 6 ]; do

    # re-initialize vars otherwise it carries over
    TOTAL_TEMP=0
    TOTAL_PER=0

    CPU=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')
    TEMP=$(cat /sys/class/thermal/thermal_zone0/temp /sys/class/thermal/thermal_zone1/temp | tail -1)

    echo "$(date) | $CPU - $(( TEMP / 1000))" >> /tmp/cpu.log

    MAX_TEMP=$(cat /tmp/cpu.log | awk '{print $11}' | sort -n | tail -1)
    MIN_TEMP=$(cat /tmp/cpu.log | awk '{print $11}' | sort -n | head -1)
    
    # its gonna be 0 and 99 all the time so no point
    # MAX_CPU=$(cat ./cpu.log | awk '{print $9}' | cut -c 1-2 | tr '.' ' ' | tr '%' ' ' | sort -n | tail -1)
    # MIN_CPU=$(cat ./cpu.log | awk '{print $9}' | cut -c 1-2 | tr '.' ' ' | tr '%' ' ' | sort -n | head -1 | rev | cut -c 2- | rev)

    NUMS=$(cat /tmp/cpu.log | wc -l)
   
    # TEMPERATURES
    TEMPS=$(cat /tmp/cpu.log | awk '{print $11}')
    for i in $TEMPS; do TOTAL_TEMP=$(($TOTAL_TEMP + $i)); done
    AVG_TEMP=$(($TOTAL_TEMP / $NUMS))

    # PERCENTAGES
    PERS=$(cat /tmp/cpu.log | awk '{print $9}' | cut -c 1-2 | tr '.' ' ' | tr '%' ' ')
    for i in $PERS; do TOTAL_PER=$(($TOTAL_PER + $i)); done
    AVG_PER=$(($TOTAL_PER / $NUMS))
   
    CHG=$(($(date +%s) - $SECS)) # change, in seconds since start

    clear

    echo "--------------- CPU Monitoring Utility ---------------"
    echo "--- Running Since: $START ---"
    echo "--------------- Running For: $(($CHG / 60)) Minutes ---------------"
    echo "MIN TEMP: $MIN_TEMP°C ------------------------ MAX TEMP: $MAX_TEMP°C"
    # echo "MIN USAGE: $MIN_CPU% ------------------------- MAX USAGE: $MAX_CPU%"
    echo "AVG TEMP: $AVG_TEMP°C ------------------------- AVG USAGE: $AVG_PER%"
    echo "CUR TEMP: $(($TEMP / 1000))°C ----------------------- CUR USAGE: $CPU"
    
    sleep 1
done
