#! /usr/bin/env python3

import time
import schedule
import os


# IDEAS
#
# Make a audio file play when time to look around and when time to stop

def twenty_twenty():
    os.system("notify-send \"Look Around!\"")
    
    os.system("play -q /run/media/musa/FILEZ/Files/Downloads/Media/Audio/zMisc./Python/timer_effect/timer_end.mp3")
    time.sleep(20)
    for i in range(2):
        os.system("play -q /run/media/musa/FILEZ/Files/Downloads/Media/Audio/zMisc./Python/timer_effect/timer_end.mp3")

        

schedule.every(20).minutes.do(twenty_twenty)

while True:

    schedule.run_pending()
    time.sleep(1)
    
