FROM archlinux/archlinux
LABEL MAINTAINER="Gunnm92"

ENV noVNC_version=1.2.0
ENV websockify_version=0.9.0

# Local debug
# COPY ./mirrorlist /etc/pacman.d/mirrorlist 
# COPY ./websockify-${websockify_version}.tar.gz /websockify.tar.gz
# COPY ./noVNC-${noVNC_version}.tar.gz /noVNC.tar.gz

# Install apps
RUN echo -e " \n\
    [multilib] \n\
    Include = /etc/pacman.d/mirrorlist \n\
    " >> /etc/pacman.conf \
    useradd -m default
RUN pacman -Syu --noconfirm plasma-meta \
	xorg plasma plasma-wayland-session kde-applications \
	chromium vim wget xorg-server \
	python-numpy python-setuptools \
    wine winetricks wine-mono wine_gecko vulkan-icd-loader lib32-vulkan-icd-loader vkd3d lib32-vkd3d gvfs \
    lutris \
    steam \
	&& pacman -Scc --noconfirm

# Install noVNC
RUN	wget https://github.com/novnc/websockify/archive/v${websockify_version}.tar.gz -O /websockify.tar.gz \
	&& tar -xvf /websockify.tar.gz -C / \
	&& cd /websockify-${websockify_version} \
	&& python setup.py install \
	&& cd / && rm -r /websockify.tar.gz /websockify-${websockify_version} \
	&& wget https://github.com/novnc/noVNC/archive/v${noVNC_version}.tar.gz -O /noVNC.tar.gz \
	&& tar -xvf /noVNC.tar.gz -C / \
	&& cd /noVNC-${noVNC_version} \
	&& ln -s vnc.html index.html \
	&& rm /noVNC.tar.gz

COPY ./config/xstartup /root/.vnc/
COPY ./start.sh /

WORKDIR /root

EXPOSE 5900 6080

RUN chmod +x /start.sh

CMD [ "/start.sh" ]
