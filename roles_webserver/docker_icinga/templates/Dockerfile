FROM jordan/icinga2:2.11.2

# Add IcigaWeb2 Grafana Module 
RUN mkdir -p /usr/local/share/icingaweb2/modules/ \
    && mkdir -p /usr/local/share/icingaweb2/modules/grafana \
    && wget -q --no-cookies -O - "https://github.com/Mikesch-mp/icingaweb2-module-grafana/archive/v1.3.6.tar.gz" \
    | tar xz --strip-components=1 --directory=/usr/local/share/icingaweb2/modules/grafana -f - \
    && mkdir -p /etc/icingaweb2/modules/grafana/ \
    && ln -s /usr/local/share/icingaweb2/modules/grafana grafana \
    && true

# Install additional Paackages
RUN apt-get update \
 && apt-get install -y -q --no-install-recommends \
    git \
    curl \ 
    jq \
    dnsutils \
    python-requests \
 && apt-get autoremove -y \
 && apt-get clean \
 && rm -rf /tmp/* /var/lib/apt/lists/* /var/cache/debconf/*-old

# Pushover notification Script 
COPY notify_by_pushover.sh /opt 
RUN chmod +x /opt/notify_by_pushover.sh

# check_prometheus script 
RUN cd /opt/ && git clone https://github.com/prometheus/nagios_plugins.git

# check_openhab2 Script 
RUN cd /opt/ && git clone https://github.com/elberfeld/icinga2-plugin-openhab2.git
