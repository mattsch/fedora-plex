FROM mattsch/fedora-rpmfusion:latest
MAINTAINER Matthew Schick <matthew.schick@gmail.com>

# Install required packages
RUN dnf install -yq procps-ng && \
#                    git \
#                    pyOpenSSL \
#                    python-paramiko \
#                    python-pillow \
#                    python-devel \
#                    python-pip \
#                    procps-ng \
#                    redhat-rpm-config \
#                    smartmontools \
#                    zlib-devel && \
    dnf clean all

# Set uid/gid (override with the '-e' flag), 1000/1000 used since it's the
# default first uid/gid on a fresh Fedora install
ENV LUID=1000 LGID=1000 PLEX_VERSION="0.9.12.19.1537-f38ac80"

# Create the plex user/group
RUN groupadd -g $LGID plex && \
    useradd -c 'Plex User' -s /bin/bash -m -d /usr/lib/plexmediaserver -g $LGID -u $LUID plex
    
# Need a config and storage volume, expose proper port
VOLUME /config /storage
EXPOSE 32400

# Add scripts to install and run plex
COPY start_pms.sh install-plex.sh run-plex.sh /bin/

RUN /bin/install-plex.sh
 
# Run our script
CMD ["/bin/run-plex.sh"]

