FROM base/archlinux:2015.06.01
MAINTAINER djmattyg007

ENV BASERUNITIMAGE_VERSION=2017.01.12-2

# Add install bash script
COPY setup/root/*.sh /root/

# Run bash script to update base image, set locale, install runit and cleanup
RUN /root/install.sh && \
    rm -f /root/install.sh /root/pacman-init.sh /root/user-init.sh

# Set environment variables for the nobody user's home directory, the terminal
# and the language
ENV HOME=/home/nobody TERM=xterm LANG=en_AU.UTF-8

COPY runsvinit /usr/bin/init
ENTRYPOINT ["/usr/bin/init"]
