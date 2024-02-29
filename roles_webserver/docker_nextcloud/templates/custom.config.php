<?php
$CONFIG = array (

    // Default language
    // https://docs.nextcloud.com/server/latest/admin_manual/configuration_server/language_configuration.html#default-language
    'default_language' => 'de',

    // Default locale
    // https://docs.nextcloud.com/server/latest/admin_manual/configuration_server/language_configuration.html#default-locale
    'default_locale' => 'de_DE',

    // Default Phone Region
    // https://docs.nextcloud.com/server/latest/admin_manual/configuration_server/config_sample_php_parameters.html#default-phone-region
    'default_phone_region' => 'DE',

    // Default Timezone
    // https://docs.nextcloud.com/server/latest/admin_manual/configuration_server/config_sample_php_parameters.html#default-timezone
    'default_timezone' => 'Europe/Berlin',

    // Overwrite Host
    // https://docs.nextcloud.com/server/latest/admin_manual/configuration_server/config_sample_php_parameters.html#overwritehost
    'overwritehost' => '{{ domain }}',

    // Overwrite Protocoll 
    // https://docs.nextcloud.com/server/latest/admin_manual/configuration_server/config_sample_php_parameters.html#overwriteprotocol
    'overwriteprotocol' => 'https',

    // Overwrite Url for CLI Access
    // https://docs.nextcloud.com/server/latest/admin_manual/configuration_server/config_sample_php_parameters.html#overwrite-cli-url
    'overwrite.cli.url' => 'https://{{ domain }}',

    // Trusted Domains
    // https://docs.nextcloud.com/server/latest/admin_manual/configuration_server/config_sample_php_parameters.html#trusted-domains
    'trusted_domains' =>
    array (
        0 => '{{ domain }}',
        1 => 'app',
    ),

    // Forwarded for Headers
    // https://docs.nextcloud.com/server/latest/admin_manual/configuration_server/config_sample_php_parameters.html#forwarded-for-headers
    'forwarded_for_headers' => ['HTTP_X_FORWARDED', 'HTTP_FORWARDED_FOR'],

    // Run Maintenance Jobs at any time
    // https://docs.nextcloud.com/server/latest/admin_manual/configuration_server/background_jobs_configuration.html#parameters
    'maintenance_window_start' => 100,
);
