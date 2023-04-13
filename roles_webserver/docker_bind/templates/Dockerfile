
FROM debian:bullseye 

RUN apt-get update && apt-get install -y bind9 dnsutils && rm -rf /var/lib/apt/lists/* 
RUN touch /var/log/bind9.log

CMD /usr/sbin/named -c /etc/bind/named.conf -g 
