FROM node:19-alpine

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash git \
    && npm install --save-dev -g typescript

WORKDIR /app
RUN git clone https://github.com/elberfeld/nextcloud-uploader.git \
    && cd /app/nextcloud-uploader \
    && git checkout 940523c14018030242f9d7d661d604dfbd2ca673

WORKDIR /app/nextcloud-uploader
RUN npm install  @types/node node-cron fs date-format glob sync-mysql nextcloud-node-client
RUN tsc app.ts

CMD [ "node", "app.js" ]
