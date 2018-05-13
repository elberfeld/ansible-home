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
@         IN      TXT     "v=spf1 mx -all"


; E-Mail Autoconfig
@                       IN       TXT    "mailconf=https://autoconfig.void.ms/mail/config-v1.1.xml"
_imaps._tcp             SRV 0 1 993     mail.void.ms
_submission._tcp        SRV 0 1 587     mail.void.ms
_autodiscover._tcp      SRV 0 0 443     autodiscover.void.ms


; Matrix Server federation 
; <yourdomain.com> <ttl> IN SRV 10 0 <port> <synapse.server.name>
_matrix._tcp.void.ms.   3600    IN      SRV     10  0   8448    void.ms.



