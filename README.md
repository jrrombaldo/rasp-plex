# rasp-plex



[![Build Status](https://travis-ci.org/jrrombaldo/rasp-plex.svg?branch=master)](https://travis-ci.org/jrrombaldo/rasp-plex)


to install this container, replace the following variables and run the container

```
export dir_confg="/tmp/conf"
export dir_data="/tmp/data"
export host_name="plex_rasp"


docker run -itd \
  --net host \
  -v $dir_conf:/config \
  -v $dir_data:/data \
  --hostname=$host_name \
  --name=$host_name \
  --restart unless-stopped \
  jrromb/plex-rasp:latest
```
