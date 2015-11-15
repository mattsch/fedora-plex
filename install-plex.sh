#!/usr/bin/env bash

# Get the latest non-plexpass version if one isn't specified

INSTALLED_VER=$(rpm -q --qf "%{VERSION}-%{RELEASE}" plexmediaserver)
PLEX_PACKAGE_URL="https://downloads.plex.tv/plex-media-server/${PLEX_VERSION}/plexmediaserver-${PLEX_VERSION}.x86_64.rpm"

# Install version if it's not there
if [ "$INSTALLED_VER" != "$PLEX_VERSION" ]; then
    echo "Installing $PLEX_PACKAGE_URL"
    dnf install -y "$PLEX_PACKAGE_URL" && dnf clean all
    # Can't set limits in a docker container, set at container creation instead
    rm /etc/security/limits.d/plex.conf
fi



