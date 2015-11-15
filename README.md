# Fedora Plex Media Server Docker Container

Docker container for [Plex Media Server](https://plex.tv) using
Fedora, requires docker >= 1.6 for ulimit support.

## Usage

Create with defaults (stable PMS version):

```bash
docker create -v /path/to/config/dir:/config \
    -v /path/to/storage/dir:/storage \
    -v /etc/localtime:/etc/localtime:ro \
    -p 32400:32400 --ulimit memlock=3100000 \
    --ulimit stack=11000000 --ulimit nofile=4096 \
    --name plex mattsch/fedora-plex
```

Create with a custom uid/gid for PMS:

```bash
docker create -v /path/to/config/dir:/config \
    -v /path/to/storage/dir:/storage \
    -v /etc/localtime:/etc/localtime:ro \
    -p 32400:32400 --ulimit memlock=3100000 \
    --ulimit stack=11000000 --ulimit nofile=4096 \
    --name plex -e LUID=1005 -e LGID=1005 mattsch/fedora-plex
```

Create with a custom uid/gid and latest PMS version:

```bash
docker create -v /path/to/config/dir:/config \
    -v /path/to/storage/dir:/storage \
    -v /etc/localtime:/etc/localtime:ro \
    -p 32400:32400 --ulimit memlock=3100000 \
    --ulimit stack=11000000 --ulimit nofile=4096 \
    --name plex -e LUID=1005 -e LGID=1005 \
    -e PLEX_VERSION="0.9.14.1.1544-651f92a" mattsch/fedora-plex
```

Using host networking rather than the port forwards above will give the best
performance and allow for proper local network discovery.  However, this allows
the container to have full access to the host's networking stack.  Be sure you
understand the implications before using it.

