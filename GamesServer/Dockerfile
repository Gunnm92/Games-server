FROM ich777/debian-buster:nvidia-steam
  
RUN echo "deb http://download.opensuse.org/repositories/home:/strycore/Debian_10/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list
RUN wget -q https://download.opensuse.org/repositories/home:/strycore/Debian_10/Release.key -O- | sudo apt-key add -
RUN apt update
RUN apt -y install --no-install-recommends lutris

RUN dpkg --add-architecture i386
RUN apt-get update && apt-get -y install gnupg2 software-properties-common cabextract
RUN wget -qO - https://dl.winehq.org/wine-builds/winehq.key | apt-key add -
RUN apt-add-repository https://dl.winehq.org/wine-builds/debian/
RUN wget -O- -q https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_10/Release.key | apt-key add -
RUN	echo "deb http://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_10 ./" | tee /etc/apt/sources.list.d/wine-obs.list
RUN	apt-get update
RUN	apt -y install --install-recommends winehq-stable

RUN cd /usr/bin/ && wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
RUN chmod +x /usr/bin/winetricks

ENV DATA_DIR=/debian
ENV FORCE_UPDATE=""
ENV CUSTOM_RES_W=1280
ENV CUSTOM_RES_H=720
ENV UMASK=000
ENV UID=99
ENV GID=100
ENV DATA_PERM=770
ENV USER="Debian"
ENV ROOT_PWD="Docker!"
ENV DEV=""
ENV USER_LOCALES="en_US.UTF-8 UTF-8"
ENV WINEPREFIX /debian/prefix32
ENV WINEARCH win32

ADD /scripts/ /opt/scripts/
COPY /icons/* /usr/share/novnc/app/images/icons/
COPY /debian.png /usr/share/backgrounds/xfce/
COPY /config/* /tmp/config/
RUN chmod -R 770 /opt/scripts/
RUN chmod -R 770 /tmp/config/

EXPOSE 8080

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]
