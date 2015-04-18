_ = require "lodash"
polygonBoolean = require "2d-polygon-boolean"


jitter = ->
  # 2d-polygon-boolean doesn't handle degeneracy;
  # so we jitter all points by a tiny bit
  tinyBit = .0001
  (Math.random() * tinyBit)

module.exports = (polys) ->
  polys = _.map polys, (poly) ->
    j = jitter()
    _.map poly, (p) ->
      [p.x + j, p.y + j]

  new_polys = _.reduce polys, (p1, p2) ->
    polygonBoolean p1, p2, "and"

  _.map new_polys, (poly) ->
    _.map poly, (p) ->
      {x: p[0], y: p[1]}
