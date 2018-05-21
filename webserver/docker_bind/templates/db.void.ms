; zonefile for void.ms.
$TTL     86400
@        IN      SOA     ns1.void.ms. webmaster.void.ms. (
                         {{ansible_date_time.epoch}}         ; Serial
                         604800         ; Refresh
                         86400         ; Retry
                         2419200         ; Expire
                         86400 )       ; Negative Cache TTL

@         IN      NS      ns1

@         IN      A       {{ webserver_ext_ip }}
@         IN      AAAA    {{ webserver_ext_ip6 }}

ns1       IN      A       {{ webserver_ext_ip }}
ns1       IN      AAAA    {{ webserver_ext_ip6 }}

ns2       IN      A       {{ webserver_ext_ip }}
ns2       IN      AAAA    {{ webserver_ext_ip6 }}


; Manuelle Domains 
vpn       IN      A       {{ webserver_ext_ip }}


; Webserver-Domains 
{% for domain in webserver_domains %}

{{ domain }}    IN  A      {{ webserver_ext_ip }}
{{ domain }}    IN  AAAA   {{ webserver_ext_ip6 }}

{% endfor %}


; Zertifikats-Authoriaet festlegen 
@         IN      CAA     0 issue "letsencrypt.org"


; E-Mail Konfiguration 
@         IN      MX      10 mail
@         IN      TXT     "v=spf1 mx ~all"
@         IN      SPF     "v=spf1 mx ~all"

_dmarc.void.ms.   3600    IN   TXT   "v=DMARC1; p=none; sp=none; pct=100; rua=mailto:postmaster@void.ms; ruf=mailto:postmaster@void.ms;"

mail._domainkey   IN      TXT     ( "v=DKIM1; h=sha256; k=rsa; "
          "p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxA8UfQ+gkbCmhB7hgNO0vNlUjEzsg8Ba+dYF/kx+MZNI+nU1qRC8tJfojDJ2H/fiEFE3pjVb+bBsBR/2zRsIJZ3QxattNV0Fr6SZHcUdSkZtwfwVylyg2KfJiHq8fb8y7uDh803tT+uo24LytWAss1tRtQwJ+kQo6+BpbxytYOuxoXdWDzqJ22l+I89dmuZFgSKarWdPgUT8mL"
          "bhfAo7kZhT+q1rdm/IGojVJNAeNF96Tc3uPf9+BqOjLKMTIGabH5TvIZUqE+MNFlnQPO+D8HHVzb9T8M0TZdAw9ARX15f1F5hvNJChSL1q/2Bg9el5N14d5J/5y23UNN1KiicyHQIDAQAB" )  ; ----- DKIM key mail for void.ms


; E-Mail Autoconfig
@                       IN       TXT    "mailconf=https://autoconfig.void.ms/mail/config-v1.1.xml"
_imaps._tcp             SRV 0 1 993     mail.void.ms
_submission._tcp        SRV 0 1 587     mail.void.ms
_autodiscover._tcp      SRV 0 0 443     autodiscover.void.ms


; Matrix Server federation 
; <yourdomain.com> <ttl> IN SRV 10 0 <port> <synapse.server.name>
_matrix._tcp.void.ms.   3600    IN      SRV     10  0   8448    void.ms.



