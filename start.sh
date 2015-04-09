#!/bin/sh

# Transcode
mkdir /subsonic/transcode
cp /usr/bin/ffmpeg /subsonic/transcode/
cp /usr/bin/lame /subsonic/transcode/


# Démarrage de subsonic
HOME=/subsonic
HOST=0.0.0.0
PORT=4040
HTTPS_PORT=4050
CONTEXT_PATH=/
MAX_MEMORY=200
MUSIC_FOLDER=/music
PODCAST_FOLDER=/music/podcasts
PLAYLIST_FOLDER=/music/playlists

SUBSONIC_USER=nobody

export LANG=POSIX
export LC_ALL=en_US.UTF-8

/usr/bin/subsonic --home=$HOME \
                  --host=$HOST \
                  --port=$PORT \
                  --https-port=$HTTPS_PORT \
                  --max-memory=$MAX_MEMORY \
                  --default-music-folder=$MUSIC_FOLDER \
		  --default-podcast-folder=$PODCAST_FOLDER \
                  --default-playlist-folder=$PLAYLIST_FOLDER
		  
sleep 5
tail -f /subsonic/subsonic_sh.log
