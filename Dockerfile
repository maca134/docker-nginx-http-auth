FROM ghcr.io/linuxserver/baseimage-alpine:3.14

# install packages
RUN \
    echo "**** install build packages ****" && \
    apk add --no-cache \
        apache2-utils \
        libressl3.3-libssl \
        logrotate \
        nginx \
        openssl \
        inotify-tools && \
    rm -f /etc/nginx/http.d/default.conf && \
    echo "**** fix logrotate ****" && \
    sed -i "s#/var/log/messages {}.*# #g" /etc/logrotate.conf && \
    sed -i 's#/usr/sbin/logrotate /etc/logrotate.conf#/usr/sbin/logrotate /etc/logrotate.conf -s /config/log/logrotate.status#g' \
        /etc/periodic/daily/logrotate

# add local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME /config