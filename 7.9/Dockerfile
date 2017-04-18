FROM node:7.9.0
MAINTAINER Ryan Schlesinger <ryan@outstand.com>

ENV GOSU_VERSION 1.10
ENV DUMB_INIT_VERSION 1.2.0
ENV FSCONSUL_VERSION 0.6.4.1
ENV WATCHMAN_VERSION v4.7.0

RUN mkdir -p /tmp/build && \
    cd /tmp/build && \
    gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && \
    curl -o gosu -SL "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture)" && \
    curl -o gosu.asc -SL "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture).asc" && \
    gpg --verify gosu.asc && \
    chmod +x gosu && \
    cp gosu /bin/gosu && \
    wget https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/dumb-init_${DUMB_INIT_VERSION}_amd64 && \
    wget https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/sha256sums && \
    grep dumb-init_${DUMB_INIT_VERSION}_amd64$ sha256sums | sha256sum -c && \
    chmod +x dumb-init_${DUMB_INIT_VERSION}_amd64 && \
    cp dumb-init_${DUMB_INIT_VERSION}_amd64 /bin/dumb-init && \
    ln -s /bin/dumb-init /usr/bin/dumb-init && \
    wget -O - https://keybase.io/outstand/pgp_keys.asc | gpg --import && \
    wget -O fsconsul "https://s3.amazonaws.com/outstand-publish/fsconsul-${FSCONSUL_VERSION}" && \
    wget -O fsconsul.asc "https://s3.amazonaws.com/outstand-publish/fsconsul-${FSCONSUL_VERSION}.asc" && \
    gpg --verify fsconsul.asc && \
    chmod +x fsconsul && \
    cp fsconsul /bin/fsconsul && \
    git clone https://github.com/facebook/watchman.git \
      && cd watchman \
      && git checkout ${WATCHMAN_VERSION} \
      && ./autogen.sh \
      && ./configure --without-python \
      && make \
      && make install && \
    cd /tmp && \
    rm -rf /tmp/build && \
    rm -rf /root/.gnupg

RUN apt-get update && apt-get install -y --no-install-recommends \
    jq \
  && rm -rf /var/lib/apt/lists/*

ENV YARN_VERSION 0.23.2-1

RUN apt-key adv --keyserver pgp.mit.edu --recv D101F7899D41F3C3 && \
      echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
      apt-get update && apt-get install -y --no-install-recommends \
      yarn=${YARN_VERSION} \
  && rm -rf /var/lib/apt/lists/*
