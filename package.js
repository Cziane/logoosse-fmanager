Package.describe({
  name: 'logoosse:blobs-collections',
  version: '0.0.1',
  // Brief, one-line summary of the package.
  summary: 'Server pacakge to store blops in mongo from db',
  // URL to the Git repository containing the source code for this package.
  git: 'https://github.com/Logoosse/logoosse-blobs-collections.git',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.4.1.1');
  api.use('ecmascript');
  api.mainModule('blobs-collections.js');
});

Package.onTest(function(api) {
  api.use('ecmascript');
  api.use('tinytest');
  api.use('logoosse:blobs-collections');
  api.mainModule('blobs-collections-tests.js');
});
