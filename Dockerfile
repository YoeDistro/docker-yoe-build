FROM debian:jessie
MAINTAINER Cliff Brake <cbrake@bec-systems.com>

RUN apt-get update && \
	apt-get install -yq sudo build-essential git \
	  python man bash diffstat gawk chrpath wget cpio \
	  texinfo lzop apt-utils bc screen && \
	rm -rf /var/lib/apt-lists/* && \
	echo "dash dash/sh boolean false" | debconf-set-selections && \
	DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

RUN useradd -ms /bin/bash build && \
	usermod -aG sudo build
	
USER build
WORKDIR /home/build

