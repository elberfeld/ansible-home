FROM jonaswinkler/paperless-ng:1.5.0

RUN apt-get update && apt-get install -y \ 	
    gcc \
    ldap-utils \
    libldap2-dev \
    libsasl2-dev \
    libssl-dev \
    python3-dev \
    python3-ldap \
    python3-pyasn1

RUN pip install \     
    django-auth-ldap \
    ldap3 
