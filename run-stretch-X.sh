#!/bin/sh
docker run -it --env=DISPLAY --rm --device=/dev/input/event0 --device=/dev/vchiq --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw andrewmk/rpi-kivy:stretch
