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
@         IN      MX      10 {{ mail_domains.voidms.mxserver }}.
@         IN      TXT     "{{ mail_domains.voidms.spf }}"
@         IN      TXT     "{{ mail_domains.voidms.mailconf }}"

_autodiscover._tcp      SRV 0 0 443     autodiscover.{{ mail_domains.voidms.maildomain }}.
_imaps._tcp             SRV 0 1 993     {{ mail_domains.voidms.mxserver }}.
_pop3s._tcp             SRV 0 1 995     {{ mail_domains.voidms.mxserver }}.
_smtps._tcp             SRV 0 1 465     {{ mail_domains.voidms.mxserver }}.
_submission._tcp        SRV 0 1 587     {{ mail_domains.voidms.mxserver }}.

_dmarc.void.ms.             IN TXT "{{ mail_domains.voidms.dmarc }}"  
_domainkey.void.ms.         IN TXT "{{ mail_domains.voidms.domainkey }}"

{% for entry in mail_domains.voidms.dkim %}

{{entry.selector}}._domainkey.void.ms.   IN TXT "{{ entry.value }}"

{% endfor %}

