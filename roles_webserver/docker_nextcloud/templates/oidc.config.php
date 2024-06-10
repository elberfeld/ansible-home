<?php
$CONFIG = array (

    // Some Nextcloud options that might make sense here
    'allow_user_to_change_display_name' => false,
    'lost_password_link' => 'disabled',

    // URL of provider. All other URLs are auto-discovered from .well-known
    'oidc_login_provider_url' => '{{ oidc_global.provider_url }}',

    // Client ID and secret registered with the provider
    'oidc_login_client_id' => 'nextcloud',
    'oidc_login_client_secret' => '{{ nextcloud_oidc_secret }}',

    // Automatically redirect the login page to the provider
    'oidc_login_auto_redirect' => true,

    // Redirect to this page after logging out the user
    'oidc_login_logout_url' => '{{ oidc_global.logout_url }}',

    // If set to true the user will be redirected to the
    // logout endpoint of the OIDC provider after logout
    // in Nextcloud. After successfull logout the OIDC
    // provider will redirect back to 'oidc_login_logout_url' (MUST be set).
    'oidc_login_end_session_redirect' => false,

    // Login button text
    'oidc_login_button_text' => 'Log in with OpenID/uffd',

    // Hide the NextCloud password change form.
    'oidc_login_hide_password_form' => true,

    // Use ID Token instead of UserInfo
    'oidc_login_use_id_token' => false,

    // Attribute map for OIDC response. 
    'oidc_login_attributes' => array (
        'id' => 'preferred_username',
        'name' => 'name',
        'mail' => 'email',
        'groups' => 'groups',
        'is_admin' => 'groups_nextcloud_admin' 
    ),

    // Default group to add users to (optional, defaults to nothing)
    //'oidc_login_default_group' => 'oidc',

    // Set OpenID Connect scope
    'oidc_login_scope' => 'openid profile email groups',

    // Auto create of users new to Nextcloud from OIDC login.
    'oidc_login_disable_registration' => false,

    // Fallback to direct login if login from OIDC fails
    'oidc_login_redir_fallback' => false,

    // Auto create of groups
    'oidc_create_groups' => false,

    // Enable use of WebDAV via OIDC bearer token.
    'oidc_login_webdav_enabled' => false,

    // Enable authentication with user/password for DAV clients that do not
    // support token authentication (e.g. DAVx⁵)
    'oidc_login_password_authentication' => true,

    // The time in seconds used to cache public keys from provider.
    // The default value is 1 day.
    'oidc_login_public_key_caching_time' => 86400,

    // The minimum time in seconds to wait between requests to the jwks_uri endpoint.
    // Avoids that the provider will be DoSed when someone requests with unknown kids.
    // The default is 10 seconds.
    'oidc_login_min_time_between_jwks_requests' => 10,

    // The time in seconds used to cache the OIDC well-known configuration from the provider.
    // The default value is 1 day.
    'oidc_login_well_known_caching_time' => 86400,

);
