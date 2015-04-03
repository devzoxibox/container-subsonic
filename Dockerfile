# Builds docker image for subsonic
FROM java:7

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Update Ubuntu
RUN apt-mark hold initscripts udev plymouth
RUN apt-get update && apt-get -qy dist-upgrade 
RUN apt-get -q update && apt-get -qy install wget locales
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

# Set locale to UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# install subsonic
RUN wget http://downloads.sourceforge.net/project/subsonic/subsonic/5.2.1/subsonic-5.2.1.deb -O /tmp/subsonic.deb
RUN dpkg -i /tmp/subsonic.deb && rm /tmp/subsonic.deb

RUN ln -s /usr/bin/ffmpeg /var/subsonic/transcode/ffmpeg && \
    ln -s /usr/bin/lame /var/subsonic/transcode/lame

# Set user nobody to uid and gid of unRAID
RUN usermod -u 99 nobody
RUN usermod -g 100 nobody
RUN chown -R nobody:users /var/subsonic
RUN mkdir /subsonic && chown -R nobody:users /subsonic

EXPOSE 4050

USER nobody 

VOLUME [/subsonic]

# Transcoders
#RUN ln /var/subsonic/transcode/ffmpeg /var/subsonic/transcode/lame /subsonic/transcode

CMD /usr/bin/subsonic \
    --home=/subsonic \
    --host=0.0.0.0 \
    --https-port=4050 \
    --max-memory=200 \
    --default-music-folder=/music \
    --default-podcast-folder=/podcast \
    --default-playlist-folder=/playlist \
    && sleep 5 && tail -f /subsonic/subsonic_sh.log

