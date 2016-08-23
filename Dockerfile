FROM node:6.4.0
MAINTAINER Ryan Schlesinger <ryan@outstand.com>

ENV GOSU_VERSION 1.9
ENV DUMB_INIT_VERSION 1.1.3
ENV WATCHMAN_VERSION v4.6.0

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

# Use dapper to build fsconsul from https://github.com/Cimpress-MCP/fsconsul
COPY fsconsul /bin/fsconsul
