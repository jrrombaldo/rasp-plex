# Rasp-Plex
[![Build Status](https://travis-ci.org/jrrombaldo/rasp-plex.svg?branch=master)](https://travis-ci.org/jrrombaldo/rasp-plex)
[![](https://images.microbadger.com/badges/image/jrromb/rasp-plex.svg)](https://microbadger.com/images/jrromb/rasp-plex "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/jrromb/rasp-plex.svg)](https://microbadger.com/images/jrromb/rasp-plex "Get your own version badge on microbadger.com")
[![](https://img.shields.io/docker/pulls/jrromb/rasp-plex.svg)](https://hub.docker.com/r/jrromb/rasp-plex)


Rasp-Plex delivers a Plexmedia Media Server (PMS) Docker container ready to run on Raspberry PI. This a fork of the [Offical PMS docker images](https://github.com/plexinc/pms-docker), to add Raspberry support.


# Run Plex as a container 
Here is the command to run this container

``` bash
docker run \
-itd \
--name plex \
-p 32400:32400/tcp \
-p 3005:3005/tcp \
-p 8324:8324/tcp \
-p 32469:32469/tcp \
-p 1900:1900/udp \
-p 32410:32410/udp \
-p 32412:32412/udp \
-p 32413:32413/udp \
-p 32414:32414/udp \
-e TZ="<timezone>" \
-e PLEX_CLAIM="<claimToken>" \
-e ADVERTISE_IP="http://<hostIPAddress>:32400/" \
-h <HOSTNAME> \
-v <path/to/plex/database>:/config \
-v <path/to/transcode/temp>:/transcode \
-v <path/to/media>:/data \
jrromb/rasp-plex
```
Parameters:
 - `timzone` timezone used by the PMS (eg `Europe/London`). Complete list can be found here: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
 - `claimToken` to automatically signup the PMS into your Plex account. Obtain this token at https://www.plex.tv/claim
 - `hostIPAddress` IP address used to 
 - `path/to/plex/database` where PMS stores all its configuration
 - `path/to/transcode/temp` temporary directory used to store trasncode temp files
 - `path/to/media` where all media is stored

Alternatively, PMS container can run sharing the HOST network, instead of the bridge mode (shown above).

```bash
docker run \
-itd \
--name plex \
--network=host \
-e TZ="<timezone>" \
-e PLEX_CLAIM="<claimToken>" \
-v <path/to/plex/database>:/config \
-v <path/to/transcode/temp>:/transcode \
-v <path/to/media>:/data \
jrromb/rasp-plex
```
Futher information and options on how to run PMS container, please refer to https://github.com/plexinc/pms-docker

### Preparation
The preparation is quite simple; it only requires the Docker to be installed on you the raspberry. Ignore this section if its already installed.
To install Docker, run the folllwing with `root` privileges
``` bash
curl -sSL https://get.docker.com | sh
usermod -a -G docker <user_name>
```

## Appreciation
This is provided as free for everyone basis; however, the maintainer still having to pay for beers and tattoos. Any support is much appreciated.

[![](https://www.paypalobjects.com/en_GB/i/btn/btn_donate_SM.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=e-junior%40live.com&currency_code=GBP&source=url)
