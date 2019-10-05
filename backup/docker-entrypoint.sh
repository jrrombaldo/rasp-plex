#!/usr/bin/env sh


DIR=`pwd`


run() {
    if [ ! -d "$PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR" ]
    then
        mkdir -p "$PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR"

        mkdir -p "$PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR/Plex Media Server/Logs"

        touch "$PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR/Plex Media Server/Logs/Plex DLNA Server.log"
        touch "$PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR/Plex Media Server/Logs/Plex DLNA Server Neptune.log"
        touch "$PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR/Plex Media Server/Logs/Plex Media Server.log"
        touch "$PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR/Plex Media Server/Logs/Plex Tuner Service.log"

        ln -sf /dev/stdout "$PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR/Plex Media Server/Logs/Plex DLNA Server.log"
        ln -sf /dev/stdout "$PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR/Plex Media Server/Logs/Plex DLNA Server Neptune.log"
        ln -sf /dev/stdout "$PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR/Plex Media Server/Logs/Plex Media Server.log"
        ln -sf /dev/stdout "$PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR/Plex Media Server/Logs/Plex Tuner Service.log"


        if [ ! $? -eq 0 ]
        then
            echo "WARNING COULDN'T CREATE $PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR, MAKE SURE I HAVE PERMISSON TO DO THAT!"
            exit 1
        fi
    fi

    export LD_LIBRARY_PATH="${PLEX_MEDIA_SERVER_HOME}"
    export TMPDIR="${PLEX_MEDIA_SERVER_TMPDIR}"

    echo $PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS $PLEX_MEDIA_SERVER_MAX_STACK_SIZE $PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR

    ulimit -s $PLEX_MAX_STACK_SIZE

    (cd /usr/lib/plexmediaserver; ./Plex\ Media\ Server) 2>&1 > /dev/stdout
}


run
