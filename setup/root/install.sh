#!/bin/bash

# Exit script if return code != 0
set -e

# Configure pacman with snapshot repository
echo "Upgrade system, install additional core packages"
source /root/pacman-init.sh

# Create nobody user
source /root/user-init.sh

source /root/functions.sh

#echo "List installed packages again"
#pacman -Q --color=never

# Install any packages
aur_start
aur_build util-linux-aes
aur_build runit
aur_finish

mkdir -p /etc/service
unlink /etc/runit/runsvdir/current
ln -s /etc/service /etc/runit/runsvdir/current

# Cleanup
pacman_cleanup
