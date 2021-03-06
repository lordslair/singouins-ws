FROM alpine:3.12
MAINTAINER @Lordslair

COPY requirements.txt /requirements.txt
COPY websocket.py     /websocket.py

RUN apk update --no-cache \
    && apk add --no-cache python3 py3-pip \
    && apk add --no-cache --virtual .build-deps \
                                    gcc \
                                    libc-dev \
                                    libffi-dev \
                                    python3-dev \
                                    tzdata \
    && pip3 --no-cache-dir install -U -r /requirements.txt \
    && cp /usr/share/zoneinfo/Europe/Paris /etc/localtime \
    && apk del .build-deps \
    && rm /requirements.txt

ENTRYPOINT ["/websocket.py"]
