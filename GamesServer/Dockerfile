FROM ich777/debian-buster:nvidia-steam

RUN dpkg --add-architecture i386
RUN apt-get update && apt-get -y install gnupg2 software-properties-common cabextract libgnutls30:i386 libldap-2.4-2:i386 libgpg-error0:i386 libxml2:i386 libasound2-plugins:i386 libsdl2-2.0-0:i386 libfreetype6:i386 libdbus-1-3:i386 libsqlite3-0:i386
RUN wget -qO - https://dl.winehq.org/wine-builds/winehq.key | apt-key add -
RUN apt-add-repository https://dl.winehq.org/wine-builds/debian/
RUN wget -O- -q https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_10/Release.key | apt-key add -
RUN echo "deb http://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_10 ./" | tee /etc/apt/sources.list.d/wine-obs.list
RUN apt-get update
RUN apt -y install --install-recommends winehq-stable
 
RUN cd /usr/bin/ && wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
RUN chmod +x /usr/bin/winetricks

RUN echo "deb http://download.opensuse.org/repositories/home:/strycore/Debian_10/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list
RUN wget -q https://download.opensuse.org/repositories/home:/strycore/Debian_10/Release.key -O- | sudo apt-key add -
RUN apt update
RUN apt -y install --no-install-recommends lutris libvulkan1 libvulkan1:i386 libgl1-mesa-dri:i386 mesa-vulkan-drivers mesa-vulkan-drivers:i386 dbus-x11 zenity

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
ENV NV_DRV_V=
ENV DISPLAY=:0
ENV ENABLE_VNC_SRV="true"
ENV NVIDIA_BUILD_OPTS="-a -N -q --install-libglvnd --ui=none --no-kernel-module"
ENV PCI_ADDR=
ENV V_TERM_NR=0
ENV DFP_NR=1
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
