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
@         IN      CAA     0 issue "letsencrypt.org"

ns1       IN      A       {{ webserver_ext_ip }}
ns1       IN      AAAA    {{ webserver_ext_ip6 }}

ns2       IN      A       {{ webserver_ext_ip }}
ns2       IN      AAAA    {{ webserver_ext_ip6 }}

vpn       IN      A       {{ webserver_ext_ip }}

{% for domain in webserver_domains %}

{{ domain }}    IN  A      {{ webserver_ext_ip }}
{{ domain }}    IN  AAAA   {{ webserver_ext_ip6 }}

{% endfor %}


