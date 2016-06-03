**Application**

[Arch Linux](https://www.archlinux.org/)

**Description**

Arch Linux is an independently developed, i686/x86-64 general purpose GNU/Linux distribution versatile enough to suit any role. Development focuses on simplicity, minimalism, and code elegance.

**Build notes**

Arch Linux base image using image from Docker Hub https://hub.docker.com/r/base/archlinux/. This image is set to a snapshot by using the archive.archlinux.org website for package updates, this is required to reduce image size by preventing continual updates to packages.

This repository contains a compiled version of runsvinit, to avoid the need to manually build it within the container. This binary is not covered by the LICENSE text found within this repository. You can find the code and license for this file at the following location:
https://github.com/djmattyg007/runsvinit

**Notes**

This is a fork of binhex/arch-base that comes with runit instead of supervisor.
