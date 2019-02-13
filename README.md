# rasp-plex



[![Build Status](https://travis-ci.org/jrrombaldo/rasp-plex.svg?branch=master)](https://travis-ci.org/jrrombaldo/rasp-plex)
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fjrrombaldo%2Frasp-plex.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fjrrombaldo%2Frasp-plex?ref=badge_shield)


to install this container, replace the following variables and run the container

```
export dir_confg="/tmp/conf"
export dir_data="/tmp/data"
export host_name="plex-rasp"


docker run -itd \
  --net host \
  -v $dir_conf:/config \
  -v $dir_data:/data \
  --hostname=$host_name \
  --name=$host_name \
  --restart unless-stopped \
  jrromb/plex-rasp:latest
```


## License
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fjrrombaldo%2Frasp-plex.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Fjrrombaldo%2Frasp-plex?ref=badge_large)