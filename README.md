
#SubSonic
## Description:

Subsonic is an open source, web-based media server.

Because Subsonic was written in Java, it may be run on any operating system with Java support.
Subsonic supports streaming to multiple clients simultaneously, and supports any streamable media (including MP3, AAC, and Ogg).
Subsonic also supports on-the-fly media conversion (through the use of plugins) of most popular media formats, including WMA, FLAC, and more.

This repository contains all necessary files to build a Docker image for “SubSonic” - (http://www.subsonic.org/). Specifically for use within an unRAID environment.

![Alt text](http://www.docgreen.fr/wp-content/uploads/2011/06/subsonic-logo.png "")

## Volumes

#### /subsonic

Home directory for subsonic, subsonic stores it's log, database properties in this folder.

#### /music

Defualt music folder. If remote share ensure it's mounted before run command is issued. 

####`TZ`  
This environment variable is used to set the [TimeZone] of the container.

[TimeZone]: http://en.wikipedia.org/wiki/List_of_tz_database_time_zones
