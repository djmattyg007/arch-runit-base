#!/bin/bash

# Exit script if return code != 0
set -e

# Construct yesterday's date (cannot use todays as archive won't exist)
yesterdays_date=$(date -d "yesterday" +%Y/%m/%d)

# Now set pacman to use snapshot for packages for yesterday's date
echo 'Server = https://archive.archlinux.org/repos/'"${yesterdays_date}"'/$repo/os/$arch' > /etc/pacman.d/mirrorlist

echo "[info] content of arch mirrorlist file"
cat /etc/pacman.d/mirrorlist

# Do our best to disable color
cat /etc/pacman.conf | grep -v '^Color$' | grep -v '^ILoveCandy$' > /tmp/pacman.conf
# Turn on verbose package lists
sed -i -r 's/\[options\]/[options]\nVerbosePkgLists/' /tmp/pacman.conf
mv /tmp/pacman.conf /etc/pacman.conf

echo "Re-prepare pacman GPG key stuff"
# Upgrade pacman db to latest version
pacman-db-upgrade --nocolor
# Delete any local keys
rm -rf /root/.gnupg
# Force re-creation of /root/.gnupg and start dirmngr
dirmngr < /dev/null
# Refresh PGP keys for pacman
pacman-key --refresh-keys --nocolor

echo "Updating installed packages"
# Download all package files first
pacman -Syuw --noconfirm --noprogressbar --color=never
# Delete old cert file due to bug in ca-certificates-utils package
rm -f /etc/ssl/certs/ca-certificates.crt
# Ignore filesystem package, as it's not desirable within a docker container
pacman -Su --noconfirm --noprogressbar --color=never --ignore filesystem
# Install additional packages
pacman -S --noconfirm --noprogressbar --color=never openssl-1.0

echo "Set en_AU locale"
echo en_AU.UTF-8 UTF-8 > /etc/locale.gen
locale-gen
echo LANG="en_AU.UTF-8" > /etc/locale.conf
