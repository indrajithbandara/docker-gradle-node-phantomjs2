FROM skorochkin/java-gradle:latest

# install required packages
RUN apt-get update -qq && apt-get -y -qq --no-install-recommends install unzip curl wget ca-certificates

ENV NODE_VERSION=0.12 \
    PHANTOMJS_VERSION=2.0.0-20150528 \
    PHANTOMJS_BIN=/usr/local/bin/phantomjs2

RUN curl --silent --location https://deb.nodesource.com/setup_${NODE_VERSION} | bash - && \
    apt-get -y install nodejs && \
    npm cache clean && \
    npm install npm bower -g && \
    npm install build npm-cache -g

RUN mkdir -p /tmp/phantomjs2 && cd /tmp/phantomjs2 && \
    wget -qO- -O phantomjs2.zip https://github.com/bprodoehl/phantomjs/releases/download/v${PHANTOMJS_VERSION}/phantomjs-${PHANTOMJS_VERSION}-u1404-x86_64.zip && \
    unzip -qq phantomjs2.zip && \
    mv ./phantomjs-${PHANTOMJS_VERSION}/bin/phantomjs ${PHANTOMJS_BIN} && \
    rm -rf /tmp/phantomjs2

# cleanup
RUN apt-get -y -qq purge unzip curl wget ca-certificates && rm -rf /var/lib/apt/lists/* && apt-get clean
RUN rm -rf /tmp/* /var/tmp/*

CMD []
