##
# A light history represent what parts of the board have been lit over
# the last few seconds in quarter-second intervals (probably)
#

_ = require "lodash"
deepcopy = require "deepcopy"

intersect = require "../polygon/intersect"


now = -> (new Date()).getTime()

class LightPoly
  constructor: (poly) ->
    @endTime = @startTime = now()
    @poly = deepcopy(poly)

  ended: () ->
    @endTime = now()

module.exports = class LightHistory
  constructor: ->
    @polys = []

  addPoly: (poly) ->
    p = new LightPoly(poly)
    @polys.push p
    p

  litDuringInterval: (end, duration) ->
    start = end - duration
    polys = _.filter @polys, (poly) ->
      (poly.startTime > start and poly.startTime < end or
       poly.endTime > start and poly.endTime < end)
    polys = _.pluck polys, "poly"
    intersect polys[0], polys[1]

  gc: (expirationInterval) ->
    expiration = now() - expirationInterval
    @polys = _.filter @polys, (p) ->
      p.endTime > expiration
