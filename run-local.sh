docker run --rm --device=/dev/input/event3 --device=/dev/vchiq -it -v /home/pi/apps:/usr/src/app/apps andrewmk/rpi-kivy-1.10.1:stretch python apps/xkcd/main.py
