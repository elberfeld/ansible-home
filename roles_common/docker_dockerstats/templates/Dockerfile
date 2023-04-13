FROM node:19-alpine

RUN apk update \
 && apk upgrade \
 && apk add --no-cache git

RUN mkdir -p /usr/src/app \
  && cd /usr/src/app \
  && git clone https://github.com/elberfeld/docker_stats_exporter.git \
  && cd /usr/src/app/docker_stats_exporter \
  && git checkout 2020.07.30.1 \
  && npm install

WORKDIR /usr/src/app/docker_stats_exporter

EXPOSE 9487
ENV DOCKERSTATS_PORT=9487 DOCKERSTATS_INTERVAL=15 DEBUG=0

ENTRYPOINT [ "npm", "start" ]
