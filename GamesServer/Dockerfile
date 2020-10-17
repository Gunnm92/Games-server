FROM ich777/debian-buster:nvidia-steam 
RUN echo "deb http://download.opensuse.org/repositories/home:/strycore/Debian_10/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list
RUN wget -q https://download.opensuse.org/repositories/home:/strycore/Debian_10/Release.key -O- | sudo apt-key add -
RUN apt update
RUN apt -y install --no-install-recommends lutris
