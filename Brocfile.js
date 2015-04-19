var browserify = require('broccoli-fast-browserify');
var merge = require('broccoli-merge-trees');
var noop = require('broccoli-static-compiler');
var concat = require('broccoli-concat');

var coffeescript = require('./tasks/coffee');
var sass = require('./tasks/sass');
var BrowserSync = require('./tasks/broccoli-browser-sync');
var broccoliTestem = require('broccoli-testem-plugin');
var env = require('broccoli-env').getEnv();
var uglifyJavaScript = require('broccoli-uglify-js');

// JS

var js = coffeescript('app');

var bundledJS = browserify(js, {
  bundles: {
    'app.js': {
      entryPoints: ['app.js']
    }
  }
});

var specs = browserify(js, {
  bundles: {
    'Spec.js': {
      entryPoints: ['**/*Spec.js']
    }
  }
});


// html
var html = noop('app', {
  files: ['**/*.html'],
  srcDir: '/',
  destDir: '/'
});

// html
var music = noop('app', {
  files: ['**/*.ogg'],
  srcDir: '/',
  destDir: '/'
});

// html
var imgs = noop('app', {
  files: ['**/*.png'],
  srcDir: '/',
  destDir: '/'
});

// css
var css = sass('app', {
  sourceMap: true,
  sourceMapContents: true,
  sourceMapEmbed: true
});

css = concat(css, {
  inputFiles: ['**/*.css'],
  outputFile: '/app.css',
  wrapInFunction: false
});

// Browser-sync

if (env == 'development') {
  specs = broccoliTestem(specs, {
    src_files: ['Spec.js'] // Files paths are relative to input tree
    // Here any testem options
  });

  var sync = new BrowserSync(
    merge([bundledJS, html, css, music, imgs], {
      overwrite: true
    }));


  // merge js, css and public file trees, and export them
  module.exports = merge([specs, sync]);
} else {
  js = uglifyJavaScript(bundledJS);

  module.exports = merge([js, html, css, music, imgs]);
}
