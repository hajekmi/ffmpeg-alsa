FROM docker.io/alpine:3.20
MAINTAINER Michal Hajek <michal.hajek@daktela.com>
LABEL description="FFmpeg with ALSA support"
LABEL org.opencontainers.image.authors="Michal Hajek <michal.hajek@daktela.com>"

STOPSIGNAL SIGQUIT

WORKDIR /

COPY ./entrypoint.sh /entrypoint.sh


RUN \
    apk update && apk add alsa-utils ffmpeg && \
    apk cache clean && chmod +x /entrypoint.sh


ENTRYPOINT [ "./entrypoint.sh" ]
