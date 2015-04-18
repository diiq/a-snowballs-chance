var Filter = require('broccoli-filter');
var coffeeScript = require('coffee-script');
var convertSourceMap = require('convert-source-map');


function CoffeeScriptFilter(inputTree, options) {
  if (!(this instanceof CoffeeScriptFilter)) {
    return new CoffeeScriptFilter(inputTree);
  }

  Filter.call(this, inputTree, options);
};

CoffeeScriptFilter.prototype = Object.create(Filter.prototype);
CoffeeScriptFilter.prototype.constructor = CoffeeScriptFilter;
CoffeeScriptFilter.prototype.extensions = ['coffee'];
CoffeeScriptFilter.prototype.targetExtension = 'js';

CoffeeScriptFilter.prototype.processString = function(string, srcFile) {
  var coffeeScriptOptions = {
    bare: true,
    literate: coffeeScript.helpers.isLiterate(srcFile),
    sourceMap: true,
    inline: true,
    filename: srcFile
  };

  try {
    parts = coffeeScript.compile(string, coffeeScriptOptions);
    map = convertSourceMap.fromJSON(parts.v3SourceMap);
    map.setProperty('sources', [srcFile]);
    return parts.js + map.toComment();
  } catch (err) {
    // CoffeeScript reports line and column as zero-indexed
    // first_line/first_column properties; pass them on
    err.line = err.location && ((err.location.first_line || 0) + 1);
    err.column = err.location && ((err.location.first_column || 0) + 1);
    throw err;
  }
};

module.exports = CoffeeScriptFilter;
