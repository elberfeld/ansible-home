
# Nextcloud with OIDC Authentication via uffd 

Uffd Reference: https://git.cccv.de/uffd

## Remarks and limitations 

* Only the numeric user id from uffd can be used in nextcloud. 
* The admin group in nextcloud is added/removed if the group nextcloud_admin is set in uffd
* Groups must be created manually, groups are assigned and revoked on login 

## Setup in Nextcloud 

Nextcloud App: OpenID Connect Login (Category: Integration)

The App must be installed manually with the initial admin User or via occ command. 
Configuration ist provided in the config file 'oidc.config.php'

https://apps.nextcloud.com/apps/oidc_login
https://github.com/pulsejet/nextcloud-oidc-login


## Setup in uffd

Create Groups:

- nextcloud_access: General Access to Nextcloud 
- nextcloud_admin: This Group will be Mapped to the Group admin in Nextcloud 

Create a Service / OAuth Client: 

Only Users with goup nextcloud_access can access Nextcloud 

Client-ID: nextcloud 
Client-Secret: from file nextcloud_oidc_secret on the server
Redirect-URIs: https://<nextcloud Server Url>/index.php/apps/oidc_login/oidc

