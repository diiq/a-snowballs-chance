_ = require "lodash"
polygonBoolean = require "2d-polygon-boolean"


jitter = ->
  # 2d-polygon-boolean doesn't handle degeneracy;
  # so we jitter all points by a tiny bit
  tinyBit = .001
  (Math.random() * tinyBit)

module.exports = (polys) ->
  polys = _.map polys, (poly) ->
    j = jitter()
    _.map poly, (p) ->
      [p.x + j, p.y + j]

  if polys.length == 1
    newPolys = polys
  if polys.length == 2
    newPolys = polygonBoolean poly1, poly2, "and"

  newPolys = _.reduce polys, (p1, p2) ->
    if not p1.length
      [p2]
    else
      cleanIntersect(p1, p2)
  , []

  _.map newPolys, (poly) ->
    _.map poly, (p) ->
      {x: p[0], y: p[1]}

cleanIntersect = (polys, poly2) ->
  _.flatten _.map polys, (poly1) ->
    polygonBoolean poly1, poly2, "and"
