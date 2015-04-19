fabric = require("fabric").fabric
intersecting = require "../polygon/intersecting"

module.exports = class Goal
  constructor: (@location) ->
    @width = 25
    @height = 25

  top: -> @location.y
  left: -> @location.x
  bottom: -> @location.y + @width
  right: -> @location.x + @height

  fabricObject: () ->
    new fabric.Rect
      fill: '#7c9'
      top: @location.y
      left: @location.x
      width: @width
      height: @height
      strokeWidth: 5
      stroke: "#798"

  win: (player) ->
    intersecting player, this
