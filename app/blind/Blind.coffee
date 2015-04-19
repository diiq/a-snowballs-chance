##
# A general blind is a line that casts a shadow. The edge of the room
# is made of immobile blinds; some blinds move, or allow the player to
# move them.
#

fabric = require("fabric").fabric
deepcopy = require "deepcopy"
_ = require "lodash"

Line = require "../line/Line"


module.exports = class Blind
  constructor: (pointA, pointB, {type, constraint, appearance}) ->
    @location = pointA
    @width = pointB.x - pointA.x
    @height = pointB.y - pointA.y
    @constraint = constraint or {x: 0, y: 0}
    @type = type || 'blind'
    @appearance = appearance || {fill: '#bbaacc'}

  top: -> @location.y
  left: -> @location.x
  bottom: -> @location.y + @height
  right: -> @location.x + @width


  fabricObject: () ->
    rect = new fabric.Rect _.extend @appearance,
      top: @top()
      left: @left()
      width: @width
      height: @height

  boundingBox: () ->
    [
      @location,
      {x: @left, y: @bottom()},
      {x: @right(), y: @bottom()}
      {x: @right(), y: @top()}
    ]

  lines: () ->
    [
      new Line(
        {x: @left(), y: @top()},
        {x: @left(), y: @bottom()}
      ),

      new Line(
        {x: @right(), y: @top()},
        {x: @right(), y: @bottom()}
      ),

      new Line(
        {x: @right(), y: @top()}
        {x: @left(), y: @top()},
      ),

      new Line(
        {x: @right(), y: @bottom()}
        {x: @left(), y: @bottom()},
      )
    ]

  rayCastingPoints: () ->
    _.flatten _.map @lines(), (line) ->
      line.rayCastingPoints()
