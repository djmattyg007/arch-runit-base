#!/bin/bash

# Exit script if return code != 0
set -e

# Configure pacman with snapshot repository
echo "Prepare pacman to use snapshot repository, refresh keys, upgrade system"
source /root/pacman-init.sh

# Create nobody user
source /root/user-init.sh

source /root/functions.sh

# Install any packages
aur_start
aur_build runit
aur_finish

mkdir -p /etc/service
unlink /etc/runit/runsvdir/current
ln -s /etc/service /etc/runit/runsvdir/current

# Cleanup
pacman_cleanup
