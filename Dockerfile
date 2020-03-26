FROM python:3.6-slim AS base

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.8.0/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

# Create user (if not exist already)
RUN useradd someuser

RUN apt update -y \
    &&	apt install -y cron

ADD /install  /

ENTRYPOINT ["/init"]

