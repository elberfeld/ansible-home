FROM jordan/icinga2:2.12.1

# Install additional Paackages
RUN apt-get update \
 && apt-get install -y -q --no-install-recommends \
    curl \ 
    dnsutils \
    git \
    jq \
    libdata-validate-domain-perl \
    libdata-validate-ip-perl \
    libmonitoring-plugin-perl \
    libnet-dns-perl \
    libnet-ip-perl \
    perl \
    python-requests \
    python3 \
    python3-paho-mqtt \
 && apt-get autoremove -y \
 && apt-get clean \
 && rm -rf /tmp/* /var/lib/apt/lists/* /var/cache/debconf/*-old

# Helper Scripe  
COPY check_rbl_helper.sh /opt 
COPY notify_by_pushover.sh /opt 
RUN chmod +x /opt/*.sh

# check_prometheus script 
RUN cd /opt/ && git clone https://github.com/prometheus/nagios_plugins.git

# check_openhab2 Script 
RUN cd /opt/ && git clone https://github.com/elberfeld/icinga2-plugin-openhab2.git

# check_mqtt
RUN cd /opt/ && git clone https://github.com/jpmens/check-mqtt.git

# check_rbl
RUN cd /opt/ && git clone https://github.com/matteocorti/check_rbl.git
