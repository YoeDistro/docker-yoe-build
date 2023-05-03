FROM debian:bookworm
MAINTAINER Cliff Brake <cbrake@bec-systems.com>

ARG DEBIAN_FRONTEND=noninteractive

# Override user name at build. If build-arg is not passed, will create user named `default_user`
ARG DOCKER_USER=build

RUN \
	dpkg --add-architecture i386 && \
        apt-get update && \
	apt-get install -yq sudo build-essential git-core git-lfs \
	  python3 man bash diffstat gawk chrpath wget cpio \
	  texinfo lzop apt-utils bc screen tmux libncurses5-dev locales \
          libc6-dev-i386 doxygen libssl-dev dos2unix xvfb x11-utils \
	  g++-multilib libssl-dev:i386 libcrypto++-dev:i386 zlib1g-dev:i386 \
	  libtool libtool-bin procps python3-distutils pigz socat \
	  python3-jinja2 python3-pip python3-pexpect lz4 zstd unzip xz-utils \
	  debianutils iputils-ping python3-git pylint python3-subunit \
	  iproute2 curl iptables && \
	rm -rf /var/lib/apt-lists/* && \
	echo "dash dash/sh boolean false" | debconf-set-selections && \
	dpkg-reconfigure dash

# Create a group and user
RUN addgroup "$DOCKER_USER" && \
    useradd -ms /bin/bash -g $DOCKER_USER -G sudo $DOCKER_USER && \
    echo "${DOCKER_USER}:${DOCKER_USER}" | chpasswd  && \
    echo 'build ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN curl -o /usr/local/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.16/gosu-$(dpkg --print-architecture)" && \
    chmod +x /usr/local/bin/gosu

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

ENV LANG en_US.utf8

COPY files /

RUN chmod 0755 /entrypoint \
 && sed "s/\$DOCKER_USER/$DOCKER_USER/g" -i /entrypoint

ENTRYPOINT ["/entrypoint"]
