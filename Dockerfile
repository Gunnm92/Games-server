ADD file:9b8be2b52ee0fa31da1b6256099030b73546253a57e94cccb24605cd888bb74d in /
CMD ["bash"]
LABEL maintainer=admin@minenet.at
/bin/sh -c apt-get update && apt-get -y install --no-install-recommends wget locales procps && touch /etc/locale.gen && echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen && apt-get -y install --reinstall ca-certificates && rm -rf /var/lib/apt/lists/*
