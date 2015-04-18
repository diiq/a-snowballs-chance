##
# A general blind is a line that casts a shadow. The edge of the room
# is made of immobile blinds; some blinds move, or allow the player to
# move them.
#

fabric = require("fabric").fabric

canvas = require "../canvas"

module.exports = class Blind
  constructor: (@pointA, @pointB) ->
    @top = Math.min(@pointA.y, @pointB.y)
    @left = Math.min(@pointA.x, @pointB.x)
    @width = Math.abs(@pointA.x - @pointB.x) || 3
    @height = Math.abs(@pointA.y - @pointB.y) || 3

    canvas.add(@fabricObject())

  fabricObject: () ->
    rect = new fabric.Rect
      fill: '#bbaacc'
      top: @top
      left: @left
      width: @width
      height: @height
