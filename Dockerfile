FROM balenalib/rpi-raspbian:buster-20211025

SHELL ["/bin/bash", "-c"]

RUN apt update && apt install pkg-config libgl1-mesa-dev libgles2-mesa-dev \
   libgstreamer1.0-dev \
   gstreamer1.0-plugins-{bad,base,good,ugly} \
   gstreamer1.0-{omx,alsa} libmtdev-dev \
   xclip xsel libjpeg-dev \
   libfreetype6-dev libgl1-mesa-dev libgles2-mesa-dev \
   libdrm-dev libgbm-dev libudev-dev libasound2-dev liblzma-dev \
   libtiff-dev libwebp-dev git build-essential gir1.2-ibus-1.0 libdbus-1-dev \
   libegl1-mesa-dev libibus-1.0-5 libibus-1.0-dev libice-dev libsm-dev \
   libsndio-dev libwayland-bin libwayland-dev libxi-dev libxinerama-dev \
   libxkbcommon-dev libxrandr-dev libxss-dev libxt-dev libxv-dev \
   x11proto-randr-dev x11proto-scrnsaver-dev x11proto-video-dev \
   x11proto-xinerama-dev python3 python3-pip python3-dev \
   && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -o SDL2-2.0.10.tar.gz https://libsdl.org/release/SDL2-2.0.10.tar.gz \
   && tar -zxvf SDL2-2.0.10.tar.gz && pushd SDL2-2.0.10 \
   && ./configure --enable-video-kmsdrm --disable-video-opengl --disable-video-x11 --disable-video-rpi \
   && make -j$(nproc) && make install && popd && rm -Rf SDL2-2.0.10 && rm -f SDL2-2.0.10.tar.gz

RUN curl -o SDL2_image-2.0.5.tar.gz https://libsdl.org/projects/SDL_image/release/SDL2_image-2.0.5.tar.gz \
   && tar -zxvf SDL2_image-2.0.5.tar.gz && pushd SDL2_image-2.0.5 && ./configure \
   && make -j$(nproc) && make install && popd && rm -Rf SDL2_image-2.0.5 && rm -f SDL2_image-2.0.5.tar.gz

RUN curl -o SDL2_mixer-2.0.4.tar.gz https://libsdl.org/projects/SDL_mixer/release/SDL2_mixer-2.0.4.tar.gz \
   && tar -zxvf SDL2_mixer-2.0.4.tar.gz && pushd SDL2_mixer-2.0.4 && ./configure \
   && make -j$(nproc) && make install && popd && rm -Rf SDL2_mixer-2.0.4 && rm -f SDL2_mixer-2.0.4.tar.gz

RUN curl -o SDL2_ttf-2.0.15.tar.gz https://libsdl.org/projects/SDL_ttf/release/SDL2_ttf-2.0.15.tar.gz \
   && tar -zxvf SDL2_ttf-2.0.15.tar.gz && pushd SDL2_ttf-2.0.15 && ./configure \
   && make -j$(nproc) && make install && popd && rm -Rf SDL2_ttf-2.0.15 && rm -f SDL2_ttf-2.0.15.tar.gz

RUN ldconfig -v


# create src dir
RUN mkdir -p /usr/src/app/
ENV KIVY_HOME=/usr/src/app
# set as WORKDIR
WORKDIR /usr/src/app

# python 3 environment
RUN python3 -m pip install --upgrade pip setuptools pygments docutils

# kivy 2.0.0
RUN python3 -m pip install "kivy[full] @ https://github.com/kivy/kivy/archive/refs/tags/2.0.0.zip"

# Copy Kivy config file
COPY config.ini config.ini

# Copy my application files
RUN mkdir -p apps
COPY ./apps/ ./apps/

# runs a sample app on container start
CMD ["python3", "apps/pictures/main.py"]
