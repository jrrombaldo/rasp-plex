FROM raspbian/jessie:latest
#FROM resin/rpi-raspbian



# RUN apt-get update -y 
#   && apt-get upgrade -y

# Installing plex server
RUN apt update -y \
 && apt upgrade -y \
 && apt install -y curl apt-transport-https  -y \
#  && wget -O - https://dev2day.de/pms/dev2day-pms.gpg.key | apt-key add - \
#  && echo "deb https://dev2day.de/pms/ jessie main" | tee /etc/apt/sources.list.d/pms.list \
 && curl https://downloads.plex.tv/plex-keys/PlexSign.key | apt-key add - \
 && echo deb https://downloads.plex.tv/repo/deb public main | tee /etc/apt/sources.list.d/plexmediaserver.list \
 && apt update \
 && apt -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confnew install  plexmediaserver -y \
 && echo 'plex installed'


RUN apt -qq -y autoclean \
 && apt -qq -y autoremove \
 && apt -qq -y clean




# Setup volumes
#  - /config holds the server settings
#  - /data is where media should be mounted
VOLUME ["/config", "/data"]

# Plex config environment vars
ENV HOME=/config


#TCP: 32400 (for access to the Plex Media Server) [required]
#UDP: 1900 (for access to the Plex DLNA Server)
#TCP: 3005 (for controlling Plex Home Theater via Plex Companion)
#UDP: 5353 (for older Bonjour/Avahi network discovery)
#TCP: 8324 (for controlling Plex for Roku via Plex Companion)
#UDP: 32410, 32412, 32413, 32414 (for current GDM network discovery)
#TCP: 32469 (for access to the Plex DLNA Server)


#RUN mkdir -p $HOME/Library/Application\ Support/Plex\ Media\ Server/Logs/ \
# && touch $HOME/Library/Application\ Support/Plex\ Media\ Server/Logs/Plex\ Media\ Server.log
##RUN ln -sf /dev/stdout $HOME/Library/Application\ Support/Plex\ Media\ Server/Logs/.log
#RUN ln -sf /dev/stdout $HOME/Library/Application\ Support/Plex\ Media\ Server/Logs/Plex\ Media\ Server.log
##	&& ln -sf /dev/stderr /var/log/nginx/error.log
#
#
#
## Plex server port
EXPOSE 32400
EXPOSE 1900/udp
EXPOSE 3005
EXPOSE 5353/udp
EXPOSE 8324
EXPOSE 32410/udp
EXPOSE 32412/udp
EXPOSE 32413/udp
EXPOSE 32414/udp
EXPOSE 32469



#change these parameters in /etc/default/plexmediaserver
ENV PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS=6
ENV PLEX_MEDIA_SERVER_HOME=/usr/lib/plexmediaserver
ENV PLEX_MEDIA_SERVER_MAX_STACK_SIZE=3000
ENV PLEX_MEDIA_SERVER_TMPDIR=/tmp
ENV PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR="${HOME}/Library/Application Support"




#WORKDIR "/usr/sbin"
#CMD ["bash"]

COPY *.sh /
RUN chmod +x /*.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["run"]
