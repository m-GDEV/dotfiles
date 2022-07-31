#!/bin/bash


while [ 4 -gt 3 ]; do
	if curl google.com &> /dev/null; then
		echo "✅ $(date) - Wifi is working" | tee -a wifi_log.txt
	else
    		echo "❌ $(date) - Wifi is NOT working" | tee -a wifi_log.txt
	fi
	sleep 10
done
