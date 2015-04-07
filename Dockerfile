# Builds docker image for subsonic
FROM debian:latest

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Update Ubuntu
#RUN apt-mark hold initscripts udev plymouth
RUN apt-get update && apt-get -qy dist-upgrade 
RUN apt-get -q update && apt-get -qy install wget locales ffmpeg nano
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

# Set locale to UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Version
ENV SUBSONIC_VERSION 5.2.1

# install subsonic
RUN wget http://downloads.sourceforge.net/project/subsonic/subsonic/$SUBSONIC_VERSION/subsonic-$SUBSONIC_VERSION.deb -O /tmp/subsonic.deb
RUN dpkg -i /tmp/subsonic.deb && rm /tmp/subsonic.deb

# Transcoders
# RUN ln -s /var/subsonic/transcode/ffmpeg /usr/bin \ 
#    ln -s /var/subsonic/transcode/lame /usr/bin/


# Set user nobody to uid and gid of unRAID
RUN usermod -u 99 nobody
RUN usermod -g 100 nobody
RUN chown -R nobody:users /var/subsonic
RUN mkdir /subsonic && chown -R nobody:users /subsonic

#Port ouvert
EXPOSE 4050


VOLUME [/subsonic]


CMD /usr/bin/subsonic \
    --home=/subsonic \
    --host=0.0.0.0 \
    --https-port=4050 \
    --max-memory=200 \
    --default-music-folder=/music \
    --default-playlist-folder=/playlist \
    && sleep 5 && tail -f /subsonic/subsonic_sh.log

USER nobody 
