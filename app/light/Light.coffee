##
# A general blind is a line that casts a shadow. The edge of the room
# is made of immobile blinds; some blinds move, or allow the player to
# move them.
#

_ = require "lodash"
fabric = require("fabric").fabric
deepcopy = require "deepcopy"

canvas = require "../canvas"
Line = require "../line/Line"

module.exports = class Light
  constructor: (@location) ->

  move: (@location) ->

  litPolygon: (blinds) ->
    # Returns the polygon which this light lights.

    # Get all line segments
    lines =  _.flatten _.map blinds, (blind) -> blind.lines()

    # Get their endpoints
    points = _.flatten _.map lines, (line) -> line.rayCastingPoints()

    # Make a ray for every endpoint
    rays = _.map points, (point) => new Line @location, point

    # Sort 'em clockwise
    rays = rays.sort (rayA, rayB) -> rayA.angle - rayB.angle

    # Then find the first intersection of every ray
    _.map rays, (ray) ->
      intersections = _.map lines, (line) ->
        line.intersection(ray)
      _.min intersections, (i) -> i.rayT


  visibleFabricPoly: (blinds) ->
    points = @litPolygon(blinds)
    rects = [new fabric.Polygon deepcopy(points),
      fill: '#fff'
      opacity: .1

    ]

    rects.push(new fabric.Rect
        fill: '#fff'
        left: @location.x
        top: @location.y
        width: 10
        height: 10
    )

    new fabric.Group rects
