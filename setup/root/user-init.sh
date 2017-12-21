#!/bin/bash

# Exit script if return code != 0
set -e

# For some bizarre reason these groups have been removed from default Arch installs
groupadd -g 99 nobody
groupadd -g 100 users

# The nobody user has also been removed from default Arch installs
useradd -g users -G nobody -s /usr/bin/nologin -u 99 nobody
chown -R nobody:users /home/nobody
chmod -R 775 /home/nobody

# Add user "nobody" to primary group "users" (will remove any other group membership)
#usermod -g users nobody

# Add user "nobody" to secondary group "nobody" (will retain primary membership)
#usermod -a -G nobody nobody

# Setup env for user nobody
#mkdir -p /home/nobody
#chown -R nobody:users /home/nobody
#chmod -R 775 /home/nobody

# Ensure home directory is set for user "nobody"
#usermod -d /home/nobody nobody
