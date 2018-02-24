
FROM mhart/alpine-node:4 

RUN apk add --no-cache make gcc g++ python

ADD run.sh /run.sh
RUN chmod +x /run.sh

RUN mkdir -p /opt/iobroker/

VOLUME /opt/iobroker/
EXPOSE 8081 8082 8083 8084 

CMD /run.sh
