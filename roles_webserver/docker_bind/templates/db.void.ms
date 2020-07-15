; zonefile for void.ms.1200
; TTL min. 300 
$TTL     300
@        IN      SOA     ns1.void.ms. webmaster.void.ms. (
                         {{ ( db_void_ms.stat.mtime | string )[:9] }}         ; Serial
                         1200          ; Refresh  1200 - 43200
                         120           ; Retry  120 -7200
                         604800        ; Expire 604800 - 2419200
                         3600 )       ; Negative Cache TTL 3600 - 86400

@         IN      A       {{ hostvars['webserver1'].ext_ip4 }}
@         IN      AAAA    {{ hostvars['webserver1'].ext_ip6 }}

; Nameserver
@         IN      NS      ns1.void.ms.
@         IN      NS      ns2.void.ms.
ns1       IN      A       {{ hostvars['webserver1'].ext_ip4 }}
ns1       IN      AAAA    {{ hostvars['webserver1'].ext_ip6 }}
ns2       IN      A       {{ hostvars['webserver2'].ext_ip4 }}
ns2       IN      AAAA    {{ hostvars['webserver2'].ext_ip6 }}


; Server 
webserver1       IN      A       {{ hostvars['webserver1'].ext_ip4 }}
webserver1       IN      AAAA    {{ hostvars['webserver1'].ext_ip6 }}

webserver2       IN      A       {{ hostvars['webserver2'].ext_ip4 }}
webserver2       IN      AAAA    {{ hostvars['webserver2'].ext_ip6 }}


; Unitimedia Gateway 
gw-um     IN      A       130.180.13.105


; Webserver1-Domains 
{% for domain in hostvars['webserver1'].webserver_domains %}
{{ domain }}    IN   A       {{ hostvars['webserver1'].ext_ip4 }}    
{{ domain }}    IN   AAAA    {{ hostvars['webserver1'].ext_ip6 }}
{% endfor %}


; Webserver2-Domains 
{% for domain in hostvars['webserver2'].webserver_domains %}
{{ domain }}    IN    A       {{ hostvars['webserver2'].ext_ip4 }}
{{ domain }}    IN    AAAA    {{ hostvars['webserver2'].ext_ip6 }}
{% endfor %}


; Zertifikats-Authoriaet festlegen 
@         IN      CAA     0 issue "letsencrypt.org"


; E-Mail Konfiguration 
@         IN      MX      10 mail.void.ms.
@         IN      TXT     "v=spf1 mx a ~all"

_autodiscover._tcp      SRV 0 0 443     mail.void.ms.
_imaps._tcp             SRV 0 1 993     mail.void.ms.
_smtps._tcp             SRV 0 1 465     mail.void.ms.
_submission._tcp        SRV 0 1 587     mail.void.ms.

_domainkey         IN TXT "o=~"
dkim1._domainkey   IN TXT "v=DKIM1;k=rsa;t=s;s=email;p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC7L/+hbz3M6mSI+xU6gmgkwdR/neOMpy19KfPkRkjAnjfSRigZnWD1rubjXv+rZxmbKS6GmBNovtgR1xYeox7ezkMtWMOTPaDmL/X04cJsMxxFgRvMj4rMRHGZR6Icb8KsLUZEHnn7n/qBKFrRm1Tw1nH6dudZr7/lPshoxW99owIDAQAB"





