FROM debian:bookworm AS debian-base
ARG OS_VERSION=6.5.2
ARG BALENA_MACHINE_NAME=beagleplay
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
ENV UPDATE_FREQ=15
ENV UDEV=on
ENV DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket
RUN apt-get update && apt-get install -y \
  gnupg ca-certificates \
  && apt-get clean \
  && echo .
RUN echo "deb [arch=arm64] http://debian.beagle.cc/arm64/ bookworm main" >> /etc/apt/sources.list \
       && apt-key adv --batch --keyserver keyserver.ubuntu.com --recv-key D284E608A4C46402
RUN apt-get update && apt-get install -y \
  apt-utils \
  tio usbutils \
  less \
  curl \
  iputils-ping \
  i2c-tools \
  kmod \
  nano \
  net-tools \
  ifupdown \
  xz-utils file \
  git wget \
  vim-tiny \
  dnsmasq wireless-tools \
  bsdmainutils \
  libiio0 \
  libiio-utils \
  libncurses5 \
  libgpiod2 \
  jq \
  wpan-tools \
  modemmanager \
  network-manager \
  ndisc6 \
  bc \
  evtest \
  gpiod \
  python3 \
  python3-pip \
  python3-venv \
  apparmor-utils \
  build-essential \
  pkgconf \
  cmake \
  libdbus-1-dev \
  libglib2.0-dev \
  uhubctl \
  && apt-get clean \
  && echo .
WORKDIR /usr/src/app
COPY requirements.txt /tmp/requirements.txt
RUN python3 -m venv pylib \
  && . pylib/bin/activate \
  && pip install -r /tmp/requirements.txt \
  && echo .
