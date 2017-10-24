#!/bin/bash

# Exit script if return code != 0
set -e

# Construct yesterday's date (cannot use todays as archive won't exist)
#yesterdays_date=$(date -d "yesterday" +%Y/%m/%d)

#echo "List installed packages"
#pacman -Q --color=never
#exit 1

# Now set pacman to use snapshot for packages for yesterday's date
#echo 'Server = https://archive.archlinux.org/repos/'"${yesterdays_date}"'/$repo/os/$arch' > /etc/pacman.d/mirrorlist

#echo "Content of arch mirrorlist file"
#cat /etc/pacman.d/mirrorlist

#echo "Re-prepare pacman GPG key stuff"
# Upgrade pacman db to latest version
#pacman-db-upgrade --nocolor
# Delete any local keys
#rm -rf /root/.gnupg
# Force re-creation of /root/.gnupg and start dirmngr
#dirmngr < /dev/null
# Refresh PGP keys for pacman
#gpg --refresh-keys
#pacman-key --init && pacman-key --populate archlinux

#echo "Configure pacman GPG"
#echo "no-greeting" > /etc/pacman.d/gnupg/gpg.conf
#echo "no-permission-warning" >> /etc/pacman.d/gnupg/gpg.conf
#echo "lock-never" >> /etc/pacman.d/gnupg/gpg.conf
#echo "keyserver hkp://ipv4.pool.sks-keyservers.net" >> /etc/pacman.d/gnupg/gpg.conf
#echo "keyserver-options timeout=10" >> /etc/pacman.d/gnupg/gpg.conf

#echo "Refreshing pacman PGP keys"
#pacman-key --refresh-keys --nocolor

#echo "List installed packages"
#pacman -Q --color=never

echo "Remove package cleanup hook" # WTF?!?!? Why is this a thing????
rm /usr/share/libalpm/hooks/package-cleanup.hook

echo "Updating currently installed packages"
pacman -Sy --noconfirm --noprogressbar --color=never
pacman -S --noconfirm --noprogressbar --color=never archlinux-keyring
#pacman -Su --noconfirm --noprogressbar --color=never --ignore filesystem,cryptsetup,device-mapper,iproute2,jfsutils,libsystemd,linux,lvm2,man-db,man-pages,mdadm,netctl,openresolv,pciutils,pcmciautils,reiserfsprogs,s-nail,systemd,systemd-sysvcompat,usbutils,xfsprogs
pacman -Su --noconfirm --noprogressbar --color=never

echo "Install additional packages"
pacman -S --noconfirm --noprogressbar --color=never grep openssl-1.0 shadow

echo "Set en_AU locale"
echo en_AU.UTF-8 UTF-8 > /etc/locale.gen
locale-gen
echo LANG="en_AU.UTF-8" > /etc/locale.conf
