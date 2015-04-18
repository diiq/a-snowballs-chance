##
# A light history represent what parts of the board have been lit over
# the last few seconds in quarter-second intervals (probably)
#

_ = require "lodash"
deepcopy = require "deepcopy"

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

  gc: (expirationInterval) ->
    expiration = now() - expirationInterval
    @polys = _.filter @polys, (p) ->
      p.endTime > expiration

  evilPolys: () ->
    _.pluck(@.polys, "poly")
