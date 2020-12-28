
import ldap

from paperless.settings import *
from django_auth_ldap.config import LDAPSearch, GroupOfUniqueNamesType, GroupOfNamesType, PosixGroupType

#
# Change Authentication to LDAP
#

AUTHENTICATION_BACKENDS = (
    'django_auth_ldap.backend.LDAPBackend',
    'django.contrib.auth.backends.ModelBackend',
)


#
# AUTH LDAP SETTINGS
#

AUTH_LDAP_SERVER_URI = "ldap://{{ ldap_local.use_host }}"
AUTH_LDAP_BIND_DN = "{{ ldap_global.readonly_dn }}"
AUTH_LDAP_BIND_PASSWORD = "{{ ldap_readonly_pass }}"

AUTH_LDAP_USER_SEARCH = LDAPSearch("{{ ldap_global.search_base }}",
                                   ldap.SCOPE_SUBTREE, 
                                   "(&(uid=%(user)s)(objectClass=inetOrgPerson))"
                                   )

AUTH_LDAP_USER_ATTR_MAP = {"first_name": "givenName", "last_name": "sn", "email": "mail"}
AUTH_LDAP_PROFILE_ATTR_MAP = {"home_directory": "homeDirectory"}


AUTH_LDAP_GROUP_SEARCH = LDAPSearch("{{ ldap_global.search_base }}",
                                    ldap.SCOPE_SUBTREE, "(objectClass=groupOfUniqueNames)"
                                    )

AUTH_LDAP_GROUP_TYPE = GroupOfUniqueNamesType()

AUTH_LDAP_USER_FLAGS_BY_GROUP = {
    "is_active": "{{ ldap_global.group_active_dn }}",
    "is_staff": "{{ ldap_global.group_admin_dn }}",
    "is_superuser": "{{ ldap_global.group_admin_dn }}"
}

AUTH_LDAP_FIND_GROUP_PERMS = True
AUTH_LDAP_CACHE_GROUPS = True
AUTH_LDAP_GROUP_CACHE_TIMEOUT = 10
