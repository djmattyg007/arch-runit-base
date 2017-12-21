FROM archlinux/base:latest
MAINTAINER djmattyg007

ENV BASERUNITIMAGE_VERSION=2017.12.21-2

# Add install bash script
COPY setup/root/*.sh /root/

# Run bash script to update base image, install important additional packages, set locale, install runit and clean up
RUN /root/install.sh && \
    rm -f /root/install.sh /root/pacman-init.sh /root/user-init.sh

# Set environment variables for the nobody user's home directory, the terminal and the language
ENV HOME=/home/nobody TERM=xterm LANG=en_AU.UTF-8

COPY runsvinit /usr/bin/init
ENTRYPOINT ["/usr/bin/init"]
