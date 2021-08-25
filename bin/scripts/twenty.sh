# simple shell script alternative to twenty_20.py
# this tells you to look around every 20 mins

while [ 7 -gt 6 ]
do
	notify-send "Look Around!"
	play -q ~/Downloads/Media/Audio/zMisc./Sound\ Effects/timer_effect/timer_end.mp3
	sleep 20
	play -q ~/Downloads/Media/Audio/zMisc./Sound\ Effects/timer_effect/timer_end.mp3
	sleep 1200
done

