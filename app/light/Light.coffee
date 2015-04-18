##
# A general blind is a line that casts a shadow. The edge of the room
# is made of immobile blinds; some blinds move, or allow the player to
# move them.
#
_ = require "lodash"
fabric = require("fabric").fabric

canvas = require "../canvas"
Line = require "../line/Line"

module.exports = class Light
  constructor: (@location) ->

  visiblePoly: (blinds) ->
    console.log blinds
    lines =  _.flatten _.map blinds, (blind) -> blind.lines()
    console.log lines
    points = _.flatten _.map lines, (line) -> line.rayCastingPoints()
    console.log points
    rays = _.map points, (point) => new Line @location, point
    _.map rays, (ray) ->
      intersections = _.map lines, (line) ->
        line.intersection(ray)
      _.min intersections, (i) -> i.rayT


  visibleFabricPoly: (blinds) ->
    points = @visiblePoly(blinds)
    rects = _.map points, (point) ->
      new fabric.Rect
        fill: '#000'
        left: point.x
        top: point.y
        width: 7
        height: 7

    rects.push(new fabric.Rect
        fill: '#345'
        left: @location.x
        top: @location.y
        width: 5
        height: 5
    )

    new fabric.Group rects
