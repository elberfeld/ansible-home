FROM debian:bookworm AS build-stage

ENV DEBIAN_FRONTEND=noninteractive
ENV PYBUILD_INSTALL_ARGS="--install-lib=/usr/share/uffd/ --install-scripts=/usr/share/uffd/"
ENV PACKAGE_VERSION=v2.3.1.r21

RUN set -x && \
    apt update && \
    apt install -y --no-install-recommends \
        lsb-release \
        curl \
        ca-certificates \
        locales-all \
        git \
        python3 \
        python3-venv \
        python3-coverage \
        python3-ldap3 \
        python3-flask \
        python3-flask-sqlalchemy \
        python3-flask-migrate \
        python3-pip \
        python3-qrcode \
        python3-fido2 \
        python3-oauthlib \
        python3-flask-babel \
        python3-argon2 \
        python3-pytest \
        python3-all \
        python3-pip \
        git-buildpackage \
        debhelper \
        build-essential \
        dh-python \
        python3-mysqldb \
        python3-requests-oauthlib \
        python3-git \
        python3-prometheus-client \
        libffi-dev \
        python3-build \
        twine && \
    apt -qq clean

RUN git clone https://git.cccv.de/uffd/uffd.git
WORKDIR /uffd
# Checkout Git, Branch oidc, Commit from 2302.2024 (see Merge Request 155: https://git.cccv.de/uffd/uffd/-/merge_requests/155)
RUN git checkout c0e726a1ee3f2511087433498e29a3344cf4ed61

RUN set -x && \
    ./debian/create_changelog.py uffd > debian/changelog && \
    dpkg-buildpackage -us -uc && \
    dpkg-deb -I /*.deb && \
    dpkg-deb -c /*.deb && \
    mv /*.deb /uffd/uffd.deb

FROM debian:bookworm as app-stage

COPY --from=build-stage /uffd/uffd.deb /uffd.deb

RUN set -x && \
    apt update && \
    apt install -y --no-install-recommends /uffd.deb python3-psycopg2 python3-pymysql && \
    rm -rf /var/lib/apt/lists/* && \
    rm /uffd.deb && \
    cat /etc/uffd/uffd.cfg | grep -v "SECRET_KEY=" > /etc/uffd/uffd.cfg.tmp && \
    mv /etc/uffd/uffd.cfg.tmp /etc/uffd/uffd.cfg && \
    mkdir --parents /var/www/uffd && \
    chown root:uffd /var/www/uffd

COPY entrypoint.sh /entrypoint.sh

USER uffd
USER root

EXPOSE 3031/tcp
EXPOSE 9191/tcp

CMD bash /entrypoint.sh