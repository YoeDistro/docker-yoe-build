FROM debian:bullseye
MAINTAINER Cliff Brake <cbrake@bec-systems.com>

ARG DEBIAN_FRONTEND=noninteractive

RUN \
	dpkg --add-architecture armhf && \
        apt-get update && \
	apt-get install -yq sudo build-essential git-core git-lfs \
	  python python3 man bash diffstat gawk chrpath wget cpio \
	  texinfo lzop apt-utils bc screen libncurses5-dev locales \
          libc6-dev:armhf doxygen libssl-dev dos2unix xvfb x11-utils \
	  libssl-dev:armhf libcrypto++-dev:armhf zlib1g-dev:armhf \
	  libtool libtool-bin procps python3-distutils pigz socat \
	  python3-jinja2 python3-pip python3-pexpect lz4 zstd unzip xz-utils \
	  debianutils iputils-ping python3-git pylint3 python3-subunit \
	  iproute2 && \
	rm -rf /var/lib/apt-lists/* && \
	echo "dash dash/sh boolean false" | debconf-set-selections && \
	dpkg-reconfigure dash

RUN useradd -ms /bin/bash -p build build && \
	usermod -aG sudo build

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

ENV LANG en_US.utf8

USER build
WORKDIR /home/build
