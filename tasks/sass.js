var Filter = require('broccoli-filter');
var convertSourceMap = require('convert-source-map');
var sass = require('node-sass');
var _ = require('lodash');
var path = require('path');


function SassFilter(inputTree, options) {
  if (!(this instanceof SassFilter)) {
    return new SassFilter(inputTree, options);
  }
  this.options = options || {};
  Filter.call(this, inputTree, this.options);
};

SassFilter.prototype = Object.create(Filter.prototype);
SassFilter.prototype.constructor = SassFilter;
SassFilter.prototype.extensions = ['scss'];
SassFilter.prototype.targetExtension = 'css';

SassFilter.prototype.processString = function(string, srcFile) {
  var sassOptions = _.extend({
    data: string,
    outFile: "fred"
  }, this.options);

  result = sass.renderSync(sassOptions);
  var map = convertSourceMap.fromSource(result.css);
  map.setProperty('sources', [path.basename(srcFile)]);

  return (convertSourceMap.removeComments(result.css) +
          map.toComment({multiline: true}));
};

module.exports = SassFilter;
