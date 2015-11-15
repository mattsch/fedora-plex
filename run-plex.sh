#!/usr/bin/env bash

# Install plex if it's not there are upgrade if we want a newer version
/bin/install-plex.sh

# Check our uid/gid, change if env variables require it
if [ "$( id -u plex )" -ne "${LUID}" ]; then
    usermod -o -u ${LUID} plex
fi

if [ "$( id -g plex )" -ne "${LGID}" ]; then
    groupmod -o -g ${LGID} plex
fi

# Set permissions
chown -R plex:plex /config/ /usr/lib/plexmediaserver


exec runuser -l plex -c '/usr/bin/start_pms.sh'
