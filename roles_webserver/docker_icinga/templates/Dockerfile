FROM jordan/icinga2:2.11.2

RUN apt-get update \
 && apt-get install -y -q --no-install-recommends \
    git \
    curl \ 
    jq \
    dig \
    python-requests \
 && apt-get autoremove -y \
 && apt-get clean \
 && rm -rf /tmp/* /var/lib/apt/lists/* /var/cache/debconf/*-old

RUN cd /opt/ && git clone https://github.com/prometheus/nagios_plugins.git

RUN cd /opt/ && git clone https://github.com/elberfeld/icinga2-plugin-openhab2.git
