FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

# Install depandencies 
RUN set -x && \
    apt update && \
    apt install -y --no-install-recommends \
      ca-certificates \
      python3 \
      python3-flask \
      python3-flask-sqlalchemy \
      python3-flask-migrate \
      python3-qrcode \
      python3-fido2 \
      python3-prometheus-client \
      python3-oauthlib \
      python3-flask-babel \
      python3-argon2 \
      python3-itsdangerous \
      python3-pymysql \
      wget && \
    rm -rf /var/lib/apt/lists/* 

# Install uffd from CCCV Repo 
RUN set -x && \
    echo "deb https://packages.cccv.de/uffd bullseye main" > /etc/apt/sources.list.d/cccv-archive-bullseye.list && \
    wget https://git.cccv.de/uffd/uffd/-/raw/master/cccv-archive-key.gpg -O /etc/apt/trusted.gpg.d/cccv-archive-key.gpg && \
    apt update && \
    apt install -y --no-install-recommends uffd=2.2.0 && \
    rm -rf /var/lib/apt/lists/* 

COPY entrypoint.sh /entrypoint.sh

USER uffd
USER root

EXPOSE 3031/tcp
EXPOSE 9191/tcp

CMD bash /entrypoint.sh
