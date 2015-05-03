# Builds docker image for subsonic
FROM zoxi/container-debian:latest

# Installation des dépendances
RUN echo "deb http://www.deb-multimedia.org jessie main" >> /etc/apt/sources.list

RUN apt-get -q update && apt-get -qy install deb-multimedia-keyring lame flac openjdk-7-jre-headless
RUN apt-get -qy install ffmpeg
RUN apt-get clean


# Version de Subsonic
ENV SUBSONIC_VERSION 5.2.1

# Installation de Subsonic
RUN wget http://downloads.sourceforge.net/project/subsonic/subsonic/$SUBSONIC_VERSION/subsonic-$SUBSONIC_VERSION.deb -O /tmp/subsonic.deb
RUN dpkg -i /tmp/subsonic.deb && rm /tmp/subsonic.deb


# Ports
EXPOSE 4050

# Montage des volumes
VOLUME /subsonic
VOLUME /music

# Ajout des droits à "/subsonic"
RUN chown -R nobody:users /subsonic

# Ajout du script de démarrage 
ADD start.sh /start.sh
RUN chmod +x /*.sh

# Passage en user "nobody"
USER nobody

ENTRYPOINT ["/start.sh"]
