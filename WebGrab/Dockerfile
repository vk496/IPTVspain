FROM frolvlad/alpine-mono:5.0-glibc
WORKDIR /root
RUN apk add --no-cache bash xmlstarlet

COPY .wg++ /root/.wg++/

#Install
RUN set -ex; \
    cd .wg++; \
    ./install.sh;

COPY merge_xml.sh entry.sh /root/

ENTRYPOINT ["./entry.sh"]
