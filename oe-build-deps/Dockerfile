# this container can be used to set up a Debian OS with dependencies
# required to run OE builds.  This allows you to have a stable
# build OS, yet run on various workstations/servers with different
# or rolling updates.  It works best if the host user is the first
# user so that user/group ids match the build user in the container.
# 
# docker run -v /host-oe-workspace:/home/build/oe \
#       (cd oe && . envsetup.sh && bitbake my-image)
#

FROM debian:jessie
MAINTAINER Cliff Brake <cbrake@bec-systems.com>

RUN apt-get update && \
	apt-get install -yq sudo build-essential git \
          python man bash diffstat gawk chrpath wget cpio \
          texinfo lzop apt-utils && \
        rm -rf /var/lib/apt-lists/* && \
	echo "dash dash/sh boolean false" | debconf-set-selections && \
	DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

RUN useradd -ms /bin/bash build
RUN usermod -aG sudo build
	
USER build
WORKDIR /home/build

