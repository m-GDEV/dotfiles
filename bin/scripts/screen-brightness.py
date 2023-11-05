#!/usr/bin/env python
# https://chat.openai.com/share/832863e7-b66d-4006-8e68-b27aafe96768

import subprocess
import datetime
import time

# User-defined maximum allowed brightness (in percentage)
MAX_BRIGHTNESS = 60
PEAK_BRIGHTNESS_TIME = 43200 # 12pm noon

def setBrightness():
    brightness = 0 # program will change this according to conditions

    # Get the current time in seconds
    current_time = datetime.datetime.now()
    current_time_in_seconds = (current_time.hour * 3600)  + (current_time.minute * 60)

    # Calculate sunrise and sunset times using 'sunwait'
    sunrise_command = f'sunwait list | awk \'{{print $1}}\' | rev | cut -c 2- | rev'
    sunset_command = f'sunwait list | awk \'{{print $2}}\''

    sunrise = subprocess.check_output(sunrise_command, shell=True).decode().strip()
    sunset = subprocess.check_output(sunset_command, shell=True).decode().strip()

    # Sunrise time
    # Sunrise time (add one hour to sunrise since its not bright immediately at sunrise)
    # Screen will start to brightnen 30mins before sunrise
    sunrise_hours = int(sunrise[:2])
    sunrise_minutes = int(sunrise[3:])
    sunrise_total_in_seconds = (sunrise_hours * 3600) + (sunrise_minutes * 60)
    sunrise_total_in_seconds = sunrise_total_in_seconds - 1800

    # Sunset time (add one hour to sunset since its not dark immediately at sunset)
    # Screen will stop being bright 30mins after sunsset
    sunset_hours = int(sunset[:2])
    sunset_minutes = int(sunset[3:])
    sunset_total_in_seconds = (sunset_hours * 3600) + (sunset_minutes * 60)
    sunset_total_in_seconds = sunset_total_in_seconds + 1800

    # Before sunrise
    if current_time_in_seconds < sunrise_total_in_seconds:
        brightness = 0

    # Brightness gradually increases from sunrise to the peak (12pm noon)
    elif current_time_in_seconds >= sunrise_total_in_seconds and current_time_in_seconds < PEAK_BRIGHTNESS_TIME:
        elapsed_time = current_time_in_seconds - sunrise_total_in_seconds
        total_time = PEAK_BRIGHTNESS_TIME - sunrise_total_in_seconds
        brightness = MAX_BRIGHTNESS * elapsed_time / total_time

    # Brightness gradually decreases from the peak (12pm noon) to 0
    elif current_time_in_seconds >= PEAK_BRIGHTNESS_TIME and current_time_in_seconds < sunset_total_in_seconds:
        elapsed_time = current_time_in_seconds - PEAK_BRIGHTNESS_TIME
        total_time = sunset_total_in_seconds - PEAK_BRIGHTNESS_TIME
        brightness = MAX_BRIGHTNESS * (1 - elapsed_time / total_time)

    # After sunset
    else:
        brightness = 0  # After sunset

    # Set the screen brightness using ddcutil
    set_brightness_command = f'ddcutil setvcp 10 {int(brightness)}'
    subprocess.run(set_brightness_command, shell=True)

    print("---------- DEBUG --------")
    print(f"Current Time: {current_time}")
    print(f"Sunrise Time: {sunrise_total_in_seconds}")
    print(f"Sunset Time: {sunset_total_in_seconds}")
    print(f"BRIGHTNESS: {brightness}")
    print(f'Screen brightness set to {int(brightness)}%')
    print("--------------------------\n")

while True:
    setBrightness()
    time.sleep(600) # Sleep for 10 minutes
