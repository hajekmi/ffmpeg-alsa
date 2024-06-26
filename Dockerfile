FROM docker.io/alpine:3.20
MAINTAINER Michal Hajek <michal.hajek@daktela.com>

WORKDIR /

RUN \
    apk update && apk add alsa-utils ffmpeg && \
    apk cache clean 

CMD ["/bin/sh"]
