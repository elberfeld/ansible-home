FROM jordan/icinga2:2.14.0

# Install additional Packages 
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

# check_openhab2 Script - commit from26.03.2020
RUN cd /opt/ \
 && git clone https://github.com/elberfeld/icinga2-plugin-openhab2.git \
 && cd /opt/icinga2-plugin-openhab2/ \
 && git checkout 050d7aca8c2b0425c1c704187aad05e906792a9a

# check_mqtt
RUN cd /opt/ \
 && git clone https://github.com/jpmens/check-mqtt.git \
 && cd /opt/check-mqtt/ \
 && git checkout v3.0

# check_rbl
RUN cd /opt/ \
 && git clone https://github.com/matteocorti/check_rbl.git \
 && cd /opt/check_rbl/ \
 && git checkout v1.5.7

# prom2json -- needed for check_metric_value
RUN cd /opt/ \
 && wget https://github.com/prometheus/prom2json/releases/download/v1.3.0/prom2json-1.3.0.linux-amd64.tar.gz \
 && tar --strip-components=1 -xzvf prom2json-1.3.0.linux-amd64.tar.gz \
 && chmod ugo+x /opt/prom2json
 
# check_metric_value - commit from 16.12.2020
RUN cd /opt/ \
 && git clone https://github.com/elberfeld/check_metric_value.git \
 && cd /opt/check_metric_value/ \
 && git checkout b94d3c3e78497a05e3b4520d33421f37e4d77985 
