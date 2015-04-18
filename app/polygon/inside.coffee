inside = require "point-in-polygon"
_ = require "lodash"


module.exports = (point, poly) ->
  poly = _.map poly, (p) ->
    [p.x, p.y]

  inside([point.x, point.y], poly)
