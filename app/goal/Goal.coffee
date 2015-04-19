fabric = require("fabric").fabric
_ = require "lodash"

inside = require "../polygon/inside"
intersecting = require "../polygon/intersecting"
input = require "../input"


module.exports = class Player
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
