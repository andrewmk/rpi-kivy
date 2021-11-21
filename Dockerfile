FROM resin/rpi-raspbian:stretch-20180801

RUN apt-get update && apt-get install -yq --no-install-recommends \
    gcc libraspberrypi-dev libraspberrypi-bin libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev \
    pkg-config libgl1-mesa-dev libgles2-mesa-dev mtdev-tools\
    python-pygame python-setuptools libgstreamer1.0-dev git-core \
    gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly \
    gstreamer1.0-alsa gstreamer1.0-omx python-dev python-pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# create src dir
RUN mkdir -p /usr/src/app/
ENV KIVY_HOME=/usr/src/app
# set as WORKDIR
WORKDIR /usr/src/app
COPY config.ini config.ini

RUN pip install wheel && pip install pgen && pip install -I Cython==0.28.2 && \
   pip install pygments && pip install docutils && rm -Rf /root/.cache/*

RUN git clone -b 1.10.1 --depth 1 https://github.com/kivy/kivy \
     && cd kivy && python setup.py build && python setup.py install && cd .. && rm -Rf kivy

# Copy my application files
RUN mkdir -p apps
COPY ./apps/ ./apps/

# runs a sample app on container start
CMD ["python", "apps/pictures/main.py"]
