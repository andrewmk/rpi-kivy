#!/bin/sh
docker run -it --rm --device=/dev/input/event0 --device=/dev/vchiq andrewmk/rpi-kivy:stretch $*
