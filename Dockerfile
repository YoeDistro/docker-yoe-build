FROM debian:stretch
MAINTAINER Cliff Brake <cbrake@bec-systems.com>

RUN \
	dpkg --add-architecture i386 && \
	apt-get update && \
	apt-get install -yq sudo build-essential git \
	  python python3 man bash diffstat gawk chrpath wget cpio \
	  texinfo lzop apt-utils bc screen libncurses5-dev locales \
	  doxygen libssl-dev dos2unix xvfb x11-utils \
	  libstdc++-6-dev:i386 libc6-dev:i386 g++-multilib gcc-multilib \
	  libssl-dev:i386 libcrypto++-dev:i386 zlib1g-dev:i386 \
	  libicu-dev:i386 libssl-dev:i386 zlib1g-dev:i386 \
	  procps && \
	rm -rf /var/lib/apt-lists/* && \
	echo "dash dash/sh boolean false" | debconf-set-selections && \
	DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

RUN useradd -ms /bin/bash -p build build && \
	usermod -aG sudo build

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

ENV LANG en_US.utf8

USER build
WORKDIR /home/build
