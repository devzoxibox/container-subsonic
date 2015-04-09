# Builds docker image for subsonic
FROM debian:latest

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Update Debian
RUN apt-get update && apt-get -qy dist-upgrade 
RUN apt-get -q update && apt-get -qy install wget locales lame flac ffmpeg openjdk-7-jre-headless
RUN apt-get clean
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

# Set locale to UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Version
ENV SUBSONIC_VERSION 5.2.1

# Install subsonic
RUN wget http://downloads.sourceforge.net/project/subsonic/subsonic/$SUBSONIC_VERSION/subsonic-$SUBSONIC_VERSION.deb -O /tmp/subsonic.deb
RUN dpkg -i /tmp/subsonic.deb && rm /tmp/subsonic.deb

# Set user nobody to uid and gid of unRAID
RUN usermod -u 99 nobody
RUN usermod -g 100 nobody


# Ports
EXPOSE 4050

# Mount volume
VOLUME /subsonic
VOLUME /music

RUN chown -R nobody:users /subsonic

ADD start.sh /start.sh
RUN chmod +x /*.sh


USER nobody

ENTRYPOINT ["/start.sh"]
