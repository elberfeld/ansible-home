FROM openhab/openhab:2.5.9-debian 

# Add Rapbian repositories 
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
        apt-utils \
        gnupg \
        wget && \
    apt-get clean && \ 
    rm -rf /var/lib/apt/lists/*

RUN wget https://archive.raspberrypi.org/debian/raspberrypi.gpg.key -O - | apt-key add - && \
    echo "deb http://archive.raspberrypi.org/debian/ buster main" > /etc/apt/sources.list.d/raspi.list

# Install additional packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
        arping \
        gcc \
        g++ \
		git \
		make \
        wiringpi && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install wiringpi 2.52 if the Repository Version ist currently 2.50
RUN gpio -v | grep "gpio version: 2.50" && \
    wget https://project-downloads.drogon.net/wiringpi-latest.deb && \
    dpkg -i wiringpi-latest.deb
    
# Download and install raspberry-remote
RUN cd /opt/ && \
    git clone https://github.com/xkonni/raspberry-remote.git && \
    cd /opt/raspberry-remote/ && \
    git checkout 879d5f2f01a1a435a8a5139f599b361420a5e40d && \
    CXXFLAGS=-fpermissive make send

# Helper script 
COPY raspberry-remote-send.sh /opt/raspberry-remote-send.sh
RUN chmod o+x /opt/raspberry-remote-send.sh
