FROM frolvlad/alpine-mono:5.0-glibc
WORKDIR /root
RUN apk add --no-cache bash

COPY WebGrabPlus_V2.1_install.tar.gz /root/

#Install
RUN set -ex; \
    tar zxvf WebGrabPlus_V2.1_install.tar.gz; \
    cd .wg++; \
    ./install.sh;

COPY WebGrab++.config.xml /root/.wg++/WebGrab++.config.xml

RUN .wg++/run.sh
