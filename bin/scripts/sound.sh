#! /bin/bash

# Get the hostname of the machine
host=$(hostname)

# Check if the hostname is "PC"
if [ "$host" == "PC" ]; then
    while true; do
        play -n synth 100 trim 0 0 && sleep 1
    done
else
    echo "Hostname is not PC. Exiting."
fi

