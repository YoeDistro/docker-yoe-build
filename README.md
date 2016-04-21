OE Build Container
==================

A Linux container for production OE/Yocto builds.

Why?
----

OE builds require a small number of dependencies that must be installed.  This is not a huge deal,
but can take 30-60 minutes to figure out what they all are and wait for them to install.  This 
container gives you everything you need.

Additionally, production builds require a known build environment where package versions are 
not changing.  Using a container for OE builds allows team members to use whatever Linux distro
they want on their workstations, but all have access to a common build environment for OE builds.  

Example
-------

* install git and docker
* git clone https://github.com/cbrake/oe-build.git
* cd oe-build
* git checkout jethro
* source envsetup.sh
* oe\_setup
* then run the following docker command:

```
docker run --rm -it \
  -v $(pwd):$(pwd) \
  -v ~/.ssh:/home/build/.ssh \
  -v ~/.gitconfig:/home/build/.gitconfig \
  cbrake/oe-build \
  /bin/bash -c "cd $(pwd) && source envsetup.sh && bitbake core-image-minimal"
```

Some notes on the above:

* The oe-build template that is cloned above is a simple wrapper around OE designed for product development needs.  See https://github.com/cbrake/oe-build for more information.
* The build directory is mapped into the container at the same location as the host.  This keeps things simple and minimizes confusion.
* Host ssh keys are mapped into container so that we can clone project git repos using ssh authentication.
* Host gitconfig is mapped into the container as well in case the build requires any git push operations (such as tagging).

This example illustrates several fundamental principal of Docker: 

1. use Docker for apps/standard stuff, but keep data and build dirs in your host file system
1. don't work in the context of the container, only use it to run commands (bitbake in this case)
1. don't store state in the container -- keep that in your host file system

License
-------

MIT

Author
------

Cliff Brake <cbrake@bec-systems.com>

improvements/pull requests welcome!

