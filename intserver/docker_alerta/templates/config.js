
'use strict';

angular.module('config', [])
  .constant('config', {
    'endpoint'    : "http://"+window.location.hostname+":8080/api",
    'provider'    : "basic", // google, github, gitlab, saml2 or basic

    'dates': {
      'shortTime' : 'HH:MM',  
      'mediumDate': 'd.MM.yyyy', 
      'longDate'  : 'EEEE, MMMM d, yyyy HH:MM ss.sss (Z)'  // Tuesday, April 26, 2016 13:39:43.987 (+0100)
    },

    'refresh_interval': 30000 // Auto-refresh interval set to 30 seconds 
});
