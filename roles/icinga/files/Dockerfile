# Dockerfile for icinga2 with icingaweb2
# Derived from https://github.com/jjethwa/icinga2

FROM debian:jessie

MAINTAINER Christian Elberfeld <elberfeld@web.de> 

LABEL version="2.4.1"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update \
    && apt-get -qqy upgrade \
    && apt-get -qqy install --no-install-recommends bash sudo procps ca-certificates wget supervisor mysql-server mysql-client apache2 pwgen unzip php5-ldap ssmtp mailutils vim
RUN wget --quiet -O - https://packages.icinga.org/icinga.key | apt-key add -
RUN echo "deb http://packages.icinga.org/debian icinga-jessie-snapshots main" >> /etc/apt/sources.list
RUN apt-get -qq update \
    && apt-get -qqy install --no-install-recommends icinga2 icinga2-ido-mysql nagios-plugins icingaweb2 \
    && apt-get clean

# Temporary hack to get icingaweb2 modules via git
RUN mkdir -p /etc/icingaweb2/enabledModules
RUN wget --no-cookies "https://github.com/Icinga/icingaweb2/archive/master.zip" -O /tmp/icingaweb2.zip
RUN unzip /tmp/icingaweb2.zip "icingaweb2-master/modules/doc/*" "icingaweb2-master/modules/monitoring/*" -d "/tmp/icingaweb2"
RUN cp -R /tmp/icingaweb2/icingaweb2-master/modules/monitoring /etc/icingaweb2/modules/
RUN cp -R  /tmp/icingaweb2/icingaweb2-master/modules/doc /etc/icingaweb2/modules/
RUN rm -rf /tmp/icingaweb2.zip /tmp/icingaweb2

ADD run /opt/
RUN chmod u+x /opt/run

ADD apache2_supervisor /opt/supervisor/
ADD icinga2_supervisor /opt/supervisor/
ADD mysql_supervisor /opt/supervisor/
RUN chmod u+x /opt/supervisor/mysql_supervisor /opt/supervisor/icinga2_supervisor /opt/supervisor/apache2_supervisor

ADD supervisor_icinga2.conf /etc/supervisor/conf.d/icinga2.conf

ADD icingaweb2_authentication.ini /etc/icingaweb2/authentication.ini
ADD icingaweb2_config.ini /etc/icingaweb2/config.ini
ADD icingaweb2_resources.ini /etc/icingaweb2/resources.ini
ADD icingaweb2_roles.ini /etc/icingaweb2/roles.ini

ADD icingaweb2_monitoring_backends.ini /etc/icingaweb2/modules/monitoring/backends.ini
ADD icingaweb2_monitoring_commandtransports.ini /etc/icingaweb2/modules/monitoring/commandtransports.ini
ADD icingaweb2_monitoring_config.ini /etc/icingaweb2/modules/monitoring/config.ini

EXPOSE 80 443 5665

VOLUME  ["/etc/icinga2", "/etc/icinga-web", "/etc/icingaweb2", "/var/lib/mysql", "/var/lib/icinga2", "/etc/ssmtp"]

# Initialize and run Supervisor
ENTRYPOINT ["/opt/run"]