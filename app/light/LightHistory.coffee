##
# A light history represent what parts of the board have been lit over
# the last few seconds in quarter-second intervals (probably)
#
intersect = require "../polygon/intersect"

now = -> (new Date()).getTime()

class LightPoly
  constructor(@poly) ->
    @endTime = @startTime = now()

  ends() ->
    @endTime = now()

module.exports = class LightHistory
  constructor: () ->
    @polys = []

  addPoly: (poly) ->
    p = LightPoly(poly)
    @polys.push p
    p

  litDuringInterval: (end, duration) ->
    start = end - duration
    polys = _.filter @polys, (poly) ->
      (poly.startTime > start and poly.startTime < end or
       poly.endTime > start and poly.endTime < end)
    intersect _.flatten _.pluck polys, "poly"

  litDuringLastNIntervals: (n, intervalDuration) ->
    t = now()
    polys = []
    for i = 0; i < n; i++
      polys.push(@litDuringInterval(t, intervalDuration))
      t = t - intervalDuration
    intersect _.flatten polys
