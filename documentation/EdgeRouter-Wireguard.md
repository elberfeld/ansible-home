
# Install Anleitung 
https://github.com/Lochnair/vyatta-wireguard

# Wireguard tunnel to webserver1
set interfaces wireguard wg1 address 10.51.1.2/24
set interfaces wireguard wg1 listen-port 51821
set interfaces wireguard wg1 route-allowed-ips true

set interfaces wireguard wg1 peer PUBKEY-WEBSERVER1 endpoint 159.69.194.128:51820
set interfaces wireguard wg1 peer PUBKEY-WEBSERVER1 allowed-ips 10.51.1.0/24
set interfaces wireguard wg1 peer PUBKEY-WEBSERVER1 allowed-ips 10.100.1.1/32

set interfaces wireguard wg1 private-key PRIVKEY-INTERFACE

set firewall name WAN_LOCAL rule 50 action accept
set firewall name WAN_LOCAL rule 50 protocol udp
set firewall name WAN_LOCAL rule 50 description 'WireGuard1'
set firewall name WAN_LOCAL rule 50 destination port 51820

# wireguard tunnel to webserver2 
set interfaces wireguard wg2 address 10.51.2.2/24
set interfaces wireguard wg2 listen-port 51822
set interfaces wireguard wg2 route-allowed-ips true

set interfaces wireguard wg2 peer PUBKEY-WEBSERVER2 endpoint 116.203.41.76:51820
set interfaces wireguard wg2 peer PUBKEY-WEBSERVER2 allowed-ips 10.51.2.0/24
set interfaces wireguard wg2 peer PUBKEY-WEBSERVER2 allowed-ips 10.100.1.2/32

set interfaces wireguard wg2 private-key PRIVKEY-INTERFACE

set firewall name WAN_LOCAL rule 60 action accept
set firewall name WAN_LOCAL rule 60 protocol udp
set firewall name WAN_LOCAL rule 60 description 'WireGuard'
set firewall name WAN_LOCAL rule 60 destination port 51820

