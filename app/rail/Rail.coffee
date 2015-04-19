fabric = require("fabric").fabric


module.exports = class Rail
  constructor: (direction, location) ->
    if direction == 'y'
      @top = @top2 = -100
      @left = location
      @left2 = location - 1
      @width = 1
      @height = 700

    if direction == 'x'
      @top = location
      @top2 = location - 1
      @left = @left2 = -100
      @width = 700
      @height = 1

  fabricObject: () ->
    new fabric.Group [
      new fabric.Rect
        fill: '#444'
        top: @top
        left: @left
        width: @width
        height: @height
      new fabric.Rect
        fill: '#222'
        top: @top2
        left: @left2
        width: @width
        height: @height
    ]
