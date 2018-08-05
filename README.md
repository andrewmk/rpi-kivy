# rpi-kivy
Docker images for running Kivy apps on a Raspberry Pi 3

## Install Raspbian stretch
## Install docker
`curl -sSL https://get.docker.com | sh`
## Run app
`docker run --rm -it andrewmk/rpi-kivy:stretch python apps/pictures/main.py`

or

`./run-stretch.sh apps/yourapp/main.py`
