FROM frolvlad/alpine-mono:5.0-glibc
WORKDIR /root
RUN apk add --no-cache bash xmlstarlet

COPY WebGrabPlus_V2.1_install.tar.gz /root/

#Install
RUN set -ex; \
    tar zxf WebGrabPlus_V2.1_install.tar.gz; \
    cd .wg++; \
    ./install.sh;

COPY merge_xml.sh entry.sh /root/

ENTRYPOINT ["./entry.sh"]
