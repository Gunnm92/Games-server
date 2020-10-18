FROM ich777/debian-baseimage

LABEL maintainer="admin@minenet.at"

RUN apt-get update && \
	apt-get -y install --no-install-recommends xvfb wmctrl x11vnc fluxbox screen novnc libxcomposite-dev && \
	sed -i '/    document.title =/c\    document.title = "noVNC";' /usr/share/novnc/app/ui.js && \
	rm -rf /var/lib/apt/lists/*

ENV CUSTOM_RES_W=640
ENV CUSTOM_RES_H=480

COPY /x11vnc /usr/bin/x11vnc
RUN chmod 751 /usr/bin/x11vnc

RUN	echo "deb http://deb.debian.org/debian bullseye main" >> /etc/apt/sources.list && \
	apt-get update && \
	apt-get -y install nano make gcc-9 bison flex bc libelf-dev squashfs-tools patch build-essential kmod cpio libncurses5-dev unzip rsync git curl bmake lsb-release libseccomp-dev libcap-dev pkg-config patchutils uuid-dev libblkid-dev libssl-dev dh-autoreconf libproc-processtable-perl beep zip libibmad-dev python3-dev python3-setuptools gperf && \
	cd /tmp && \
	wget -q -nc --show-progress --progress=bar:force:noscroll -O go.tar.gz https://golang.org/dl/go1.15.linux-amd64.tar.gz && \
	tar -C /usr/local -xvzf go.tar.gz && \
	export PATH=$PATH:/usr/local/go/bin && \
	rm -R /tmp/go* && \
	rm -rf /var/lib/apt/lists/*

RUN rm -R /lib/x86_64-linux-gnu/liblzma.* && \
	cd /tmp && \
	wget -q -nc --show-progress --progress=bar:force:noscroll -O xz.tar https://github.com/ich777/xz/releases/download/5.2.5/xz-v5.2.5.tar.gz && \
	tar -C / -xvf /tmp/xz.tar && \
	rm /tmp/xz.tar && \
	wget -q -nc --show-progress --progress=bar:force:noscroll https://github.com/ich777/python-unraid/raw/3.8.5/python-3.8.5-x86_64-1.tgz && \
	wget -q -nc --show-progress --progress=bar:force:noscroll https://github.com/ich777/python-unraid/raw/3.7.3/gobject-introspection-1.46.0-x86_64-1.txz

ENV DATA_DIR="/usr/src"
ENV UNRAID_V=6.9.0
ENV PATH=$PATH:/usr/local/go/bin
ENV GOPATH=/usr/src/go/
ENV IMAGES_FILE_PATH="/usr/src/stock"
ENV BUILD_DVB="true"
ENV BUILD_NVIDIA="true"
ENV BUILD_ZFS="false"
ENV BUILD_ISCSI="false"
ENV BUILD_MLX_MFT="false"
ENV ENABLE_i915="false"
ENV BUILD_JOYDEV="false"
ENV LIBNVIDIA_CONTAINER_V="latest"
ENV NVIDIA_CONTAINER_RUNTIME_V="latest"
ENV CONTAINER_TOOLKIT_V="latest"
ENV CUSTOM_MODE=""
ENV USER_PATCHES=""
ENV DD_DRV_V="latest"
ENV LE_DRV_V="latest"
ENV NV_DRV_V="latest"
ENV SECCOMP_V="latest"
ENV ZFS_V="master"
ENV TARGETCLI_FB_V="latest"
ENV RTSLIB_FB_V="latest"
ENV CONFIGSHELL_FB_V="latest"
ENV MLX_MFT_V="latest"
ENV CLEANUP="full"
ENV CREATE_BACKUP="true"
ENV UNAME=""
ENV BETA_BUILD=""
ENV BEEP="true"
ENV SAVE_LOG="false"
ENV BUILD_FROM_SOURCE="false"
ENV DONTWAIT=""
ENV UMASK=000
ENV UID=99
ENV GID=100
ENV DATA_PERM=770
ENV USER="kernel"

RUN dpkg --add-architecture i386
RUN apt-get update && apt-get -y install gnupg2 software-properties-common cabextract libgnutls30:i386 libldap-2.4-2:i386 libgpg-error0:i386 libxml2:i386 libasound2-plugins:i386 libsdl2-2.0-0:i386 libfreetype6:i386 libdbus-1-3:i386 libsqlite3-0:i386
RUN wget -qO - https://dl.winehq.org/wine-builds/winehq.key | apt-key add -
RUN apt-add-repository https://dl.winehq.org/wine-builds/debian/
RUN wget -O- -q https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_10/Release.key | apt-key add -
RUN echo "deb http://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_10 ./" | tee /etc/apt/sources.list.d/wine-obs.list
RUN apt-get update
RUN apt-get -y install --install-recommends winehq-stable
 
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

RUN mkdir -p $DATA_DIR && \
	useradd -d $DATA_DIR -s /bin/bash $USER && \
	chown -R $USER $DATA_DIR && \
	ulimit -n 2048
 
ADD /scripts/ /opt/scripts/
COPY /icons/* /usr/share/novnc/app/images/icons/
COPY /debian.png /usr/share/backgrounds/xfce/
COPY /config/* /tmp/config/
RUN chmod -R 770 /opt/scripts/
RUN chmod -R 770 /tmp/config/

EXPOSE 8080

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]
