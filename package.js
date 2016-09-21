Package.describe({
  name: 'logoosse:fmanager',
  version: '0.0.1',
  // Brief, one-line summary of the package.
  summary: 'Server pacakge to store files in meteor app with mongodb or filemanger',
  // URL to the Git repository containing the source code for this package.
  git: 'https://github.com/Logoosse/logoosse-fmanager.git',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.4.1.1');
  api.use('nimble:restivus');
  api.use('aldeed:collection2');
  api.use('coffeescript');
  api.use('jparker:crypto-md5');

});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('logoosse:blobs-collections');
  api.mainModule('blobs-collections-tests.js');
});
