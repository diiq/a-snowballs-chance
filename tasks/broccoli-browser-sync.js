var Filter = require('broccoli-filter');
var browserSync = require('browser-sync');
var _ = require('lodash');

var snippet = "<script type='text/javascript' id='__bs_script__'>\n" +
  "document.write(\"<script async " +
  "src='http://HOST:3000/browser-sync/browser-sync-client.2.6.4.js'>" +
  "<\\/script>\".replace('HOST', location.hostname));" +
  "</script>\n";

var debouncedReload = _.debounce(function() {
  browserSync.reload();
});

function BrowserSyncFilter (inputTree, options) {
  browserSync({
    logSnippet: false,
    notify: false
  });
  Filter.call(this, inputTree, options);
  options = options || {};
};

BrowserSyncFilter.prototype = Object.create(Filter.prototype);

BrowserSyncFilter.prototype.constructor = BrowserSyncFilter;

BrowserSyncFilter.prototype.extensions = ['html', 'js', 'css'];

BrowserSyncFilter.prototype.processString = function (string, srcFile) {
  browserSync.reload(srcFile);
  console.log(srcFile);
  if (_.endsWith(srcFile, '.html')) {
    return string.replace("</body>", snippet + "</body>");
  } else {
    return string;
  }
};

module.exports = BrowserSyncFilter;
