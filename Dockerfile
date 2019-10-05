FROM raspbian/jessie:latest


#ARG S6_OVERLAY_VERSION=v1.17.2.0
ARG S6_OVERLAY_VERSION=v1.22.1.0
ARG DEBIAN_FRONTEND="noninteractive"
ENV TERM="xterm" LANG="C.UTF-8" LC_ALL="C.UTF-8"

COPY root/ /


RUN \
# Update and get dependencies
    apt-get update \
    && apt install curl apt-transport-https -y \
    && curl https://downloads.plex.tv/plex-keys/PlexSign.key | apt-key add - \
    && echo deb https://downloads.plex.tv/repo/deb public main | tee /etc/apt/sources.list.d/plexmediaserver.list \
    && apt-get update \
    && apt -y --force-yes -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confnew install plexmediaserver \

# Fetch and extract S6 overlay
    && curl -J -L -o /tmp/s6-overlay-arm.tar.gz https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-arm.tar.gz \
    && tar xzf /tmp/s6-overlay-arm.tar.gz -C / \

# Add directories and user
    && mkdir -p \
      /config \
      /transcode \
      /data \
    # && \useradd -U -d /config -s /bin/false plex \
    # && usermod -G users plex \

# Cleanup
    && apt-get -y autoremove \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

EXPOSE 32400/tcp 3005/tcp 8324/tcp 32469/tcp 1900/udp 32410/udp 32412/udp 32413/udp 32414/udp
VOLUME /config /transcode /data

ENV CHANGE_CONFIG_DIR_OWNERSHIP="true" \
    HOME="/config"



# RUN \
# # Save version and install
#     /installBinary.sh

ENTRYPOINT ["/init"]
HEALTHCHECK --interval=5s --timeout=2s --retries=20 CMD /usr/local/bin/healthcheck.sh || exit 1
