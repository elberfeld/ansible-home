; zonefile for void.ms.
$TTL    86400
@       IN      SOA     ns1.void.ms. webmaster.void.ms. (
                     {{ansible_date_time.epoch}}         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                          86400 )       ; Negative Cache TTL

@       IN      NS      ns1
ns1     IN      A       {{ webserver_ext_ip }}
ns2     IN      A       {{ webserver_ext_ip }}

{% for domain in webserver_domains %}

{{domain }}    IN  A   {{ webserver_ext_ip }}

{% endfor %}


