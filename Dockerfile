FROM ubuntu:24.04

RUN apt-get update && \
    apt-get --no-install-recommends install --assume-yes apt-transport-https ca-certificates gnupg nano curl bash libglib* libnss3*

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 22.9.0

RUN mkdir $NVM_DIR

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN node -v
RUN npm -v

WORKDIR /srv/wdiotest/

COPY . /srv/wdiotest/

RUN npm install -g npm && npm install

CMD npm run wdio