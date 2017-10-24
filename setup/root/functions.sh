#!/bin/bash

# Exit script if return code != 0
set -e

pacman_cleanup() {
    yes | pacman -Scc --noprogressbar --color=never
    rm -rf /usr/share/locale/*
    rm -rf /usr/share/man/*
    rm -rf /tmp/*
}

aur_start() {
    echo "Preparing to build AUR packages"
    # Install packages that all PKGBUILDs automatically assume are installed
    # Also install ed, it's a build-time dependency of runit
    pacman -S --needed --noconfirm --noprogressbar --color=never --ignore systemd base-devel ed
    # Create "makepkg-user" user for building packages, as we can't and shouldn't
    # build packages as root (although we're effectively root all the time when
    # interacting with docker, so it's a bit of a moot point...)
    useradd -m -s /bin/bash makepkg-user
    echo -e "makepkg-password\nmakepkg-password" | passwd makepkg-user
}

aur_finish() {
    echo "Finished building AUR packages"
    # Remove "makepkg-user" - we don't want unnecessary users lying around in the image
    userdel -r makepkg-user
    # Remove base-devel packages, except a few useful core packages
    pacman -Ru --noconfirm --noprogressbar --color=never $(pacman -Qgq base-devel | grep -v pacman | grep -v sed | grep -v grep | grep -v gzip)
    # Remove ed
    pacman -Ru --noconfirm --noprogressbar --color=never ed
}

aur_build() {
    local pkg=$1

    # Download and extract package files from AUR
    local tar_path="/tmp/${pkg}.tar.gz"
    curl -s -L -o ${tar_path} "https://aur.archlinux.org/cgit/aur.git/snapshot/${pkg}.tar.gz"
    tar xvf ${tar_path} -C /tmp
    chmod a+rwx /tmp/${pkg}

    # hack to fix runit install
    if [[ "${pkg}" == "runit" ]]; then
        sed -i 's/util-linux-ng/util-linux/' /tmp/${pkg}/PKGBUILD
    fi

    echo "Building ${pkg}"
    su -c "cd /tmp/${pkg} && makepkg --nocolor --noprogressbar" - makepkg-user

    echo "Installing ${pkg}"
    pkg_filename=$(ls --color=never -1 /tmp/${pkg}/${pkg}-*-x86_64.pkg.tar.xz 2> /dev/null || true)
    if [[ -n "${pkg_filename}" ]]; then
        pacman -U /tmp/${pkg}/${pkg}-*-x86_64.pkg.tar.xz --noconfirm --noprogressbar --color=never
    else
        pacman -U /tmp/${pkg}/${pkg}-*-any.pkg.tar.xz --noconfirm --noprogressbar --color=never
    fi
}
