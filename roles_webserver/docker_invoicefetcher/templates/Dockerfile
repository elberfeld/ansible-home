FROM node:10-alpine

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash git \
    && npm install --save-dev -g typescript

WORKDIR /app
RUN git clone https://github.com/elberfeld/nextcloud-uploader.git \
    && cd /app/nextcloud-uploader \
    && git checkout b15c5d97acea24c952e8b8c265e572203f98490d

WORKDIR /app/nextcloud-uploader
RUN npm install  @types/node node-cron fs date-format glob nextcloud-node-client
RUN tsc app.ts

CMD [ "node", "app.js" ]
