
# Use Nginx Debian as Base
FROM nginx:1.11.10 

# Install additional SSH only for this container
RUN apt-get update \
  && apt-get install -y openssh-server

# .ssh Verzeichnis im Home anlegen 
# Login für www-data erlauben 
RUN mkdir /var/www/ \
   && mkdir /var/www/.ssh \
   && chmod 755 /var/www/.ssh \
   && chown -R root:root /var/www/.ssh \
   &&  mkdir /etc/ssh/keys \
   &&  mkdir /var/run/sshd \
   && usermod -s /bin/bash www-data

COPY sshd_config /etc/ssh/sshd_config
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 22 
EXPOSE 80

CMD ["/entrypoint.sh"]
