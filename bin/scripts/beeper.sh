#!/bin/bash

# Find the latest Beeper AppImage
latest_beeper=$(ls -t /home/musa/Downloads/APPS/AppImage/beeper-* | head -1)

# Update the desktop file with sudo permission
sudo sed -i "s|Exec=.*|Exec=$latest_beeper|" /usr/share/applications/beeper.desktop \
    && echo "Desktop file updated." \
    || echo "Error: Desktop file update unsuccessful."

