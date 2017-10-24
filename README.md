**Application**

[Arch Linux](https://www.archlinux.org/)

**Description**

Arch Linux is an independently developed, i686/x86-64 general purpose GNU/Linux distribution versatile enough to suit any role. Development focuses on simplicity, minimalism, and code elegance.

**Build notes**

This image is based off of the official Arch Linux docker image found at https://hub.docker.com/r/archlinux/base/.

This repository contains a compiled version of runsvinit, to avoid the need to manually build it within the container. This binary is not covered by the LICENSE text found within this repository. You can find the code and license for this file at the following location:
https://github.com/djmattyg007/runsvinit

**Notes**

This used to be a fork of binhex/arch-base that comes with runit instead of supervisor. It is now vastly different - practically none of the original code is still used.
