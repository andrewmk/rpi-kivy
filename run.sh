#!/bin/sh
docker run -it --rm --device=/dev/input/event0 --device=/dev/vchiq andrewmk/rpi-kivy-1.10.1:stretch $*
