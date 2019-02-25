FROM hardware/mailserver:1.1-stable

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y -q --no-install-recommends \
    postfix-ldap dovecot-ldap \
 && apt-get autoremove -y \
 && apt-get clean \
 && rm -rf /tmp/* /var/lib/apt/lists/* /var/cache/debconf/*-old

EXPOSE 25 143 465 587 993 4190 11334
CMD ["run.sh"]
