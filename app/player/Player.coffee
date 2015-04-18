fabric = require("fabric").fabric
_ = require "lodash"

inside = require "../polygon/inside"

module.exports = class Player
  constructor: (@location) ->
    @velocity = {x: 0, y: 0}
    @health = 100
    @width = 25
    @height = 25

  fabricObject: () ->
    rect = new fabric.Rect
      fill: '#798'
      top: @location.y - @height / 2
      left: @location.x - @width / 2
      width: @width
      height: @height

    healthBar = new fabric.Rect
      fill: '#7c9'
      top: 570
      left: 400
      width: @health
      height: 10

    new fabric.Group [rect, healthBar]

  updateHealth: (badPolys, steps) ->
    badCount = _.filter(badPolys, (poly) =>
      inside(@location, poly)
    ).length

    @health -= badCount * steps * .002
    if @health < 0
      alert "dead, yo"
