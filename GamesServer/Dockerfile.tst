FROM archlinux/archlinux
LABEL MAINTAINER="Gunnm92"

ENV noVNC_version=1.2.0
ENV websockify_version=0.10.0

# Local debug
# COPY ./mirrorlist /etc/pacman.d/mirrorlist 
# COPY ./websockify-${websockify_version}.tar.gz /websockify.tar.gz
# COPY ./noVNC-${noVNC_version}.tar.gz /noVNC.tar.gz

# Install apps
RUN echo -e " \n \
    [multilib] \n \
    Include = /etc/pacman.d/mirrorlist \n \
    " >> /etc/pacman.conf \
    useradd -m default

RUN pacman -Syu --noconfirm plasma-meta \
	xorg plasma plasma-wayland-session \
	
    wget xorg-server \
	tigervnc \
	python-numpy python-setuptools \
	&& pacman -Scc --noconfirm

# Install noVNC
ARG NOVNC_VERSION=1.2.0
RUN \
    echo "**** Fetch noVNC ****" \
        && cd /tmp \
        && wget -O /tmp/novnc.tar.gz https://github.com/novnc/noVNC/archive/v${NOVNC_VERSION}.tar.gz \
    && \
    echo "**** Extract noVNC ****" \
        && cd /tmp \
        && tar -xvf /tmp/novnc.tar.gz \
    && \
    echo "**** Configure noVNC ****" \
        && cd /tmp/noVNC-${NOVNC_VERSION} \
        && sed -i 's/credentials: { password: password } });/credentials: { password: password },\n                           wsProtocols: ["'"binary"'"] });/g' app/ui.js \
        && mkdir -p /opt \
        && rm -rf /opt/noVNC \
        && cd /opt \
        && mv -f /tmp/noVNC-${NOVNC_VERSION} /opt/noVNC \
        && cd /opt/noVNC \
        && ln -s vnc.html index.html \
        && chmod -R 755 /opt/noVNC \
    && \
    echo "**** Modify noVNC title ****" \
        && sed -i '/    document.title =/c\    document.title = "SteamOS - noVNC";' \
            /opt/noVNC/app/ui.js \
    && \
    echo "**** Section cleanup ****" \
        && rm -rf \
            /tmp/noVNC* \
            /tmp/novnc.tar.gz

# Install Websockify
ARG WEBSOCKETIFY_VERSION=0.10.0
RUN \
    echo "**** Fetch Websockify ****" \
        && cd /tmp \
        && wget -O /tmp/websockify.tar.gz https://github.com/novnc/websockify/archive/v${WEBSOCKETIFY_VERSION}.tar.gz \
    && \
    echo "**** Extract Websockify ****" \
        && cd /tmp \
        && tar -xvf /tmp/websockify.tar.gz \
    && \
    echo "**** Install Websockify to main ****" \
        && cd /tmp/websockify-${WEBSOCKETIFY_VERSION} \
        && python3 ./setup.py install \
    && \
    echo "**** Install Websockify to noVNC path ****" \
        && cd /tmp \
        && mv -v /tmp/websockify-${WEBSOCKETIFY_VERSION} /opt/noVNC/utils/websockify \
    && \
    echo "**** Section cleanup ****" \
        && rm -rf \
            /tmp/websockify-* \
            /tmp/websockify.tar.gz

COPY ./config/xstartup /root/.vnc/
COPY ./start.sh /

WORKDIR /root

EXPOSE 5900 6080

RUN chmod +x /start.sh

CMD [ "/start.sh" ]