fabric = require("fabric").fabric
_ = require "lodash"

inside = require "../polygon/inside"
intersecting = require "../polygon/intersecting"
input = require "../input"


module.exports = class Player
  constructor: (@location) ->
    @velocity = {x: 0, y: 0}
    @health = 100
    @width = 25
    @height = 25

  top: -> @location.y
  left: -> @location.x
  bottom: -> @location.y + @height
  right: -> @location.x + @width

  fabricObject: () ->
    rect = new fabric.Rect
      fill: '#798'
      top: @location.y
      left: @location.x
      width: @width
      height: @height

    healthBar = new fabric.Rect
      fill: '#7c9'
      top: 570
      left: 480
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

  setVelocity: () ->
    @velocity =
      x: @velocity.x * .75,
      y: @velocity.y * .75

    if input.isKeyDown "up"
      @velocity.y = -.1
    if input.isKeyDown "down"
      @velocity.y = .1
    if input.isKeyDown "left"
      @velocity.x = -.1
    if input.isKeyDown "right"
      @velocity.x = .1

  checkCollisions: (blocks) ->
    _.find(blocks, (block) => intersecting this, block)

  move: (steps, blocks) ->
    @setVelocity()
    oldLocation = {x: @location.x, y: @location.y}
    @location.x += @velocity.x * steps
    @location.y += @velocity.y * steps

    block = @checkCollisions(blocks)
    if block
      @location = oldLocation
      @velocity =
        x: block.constraint.x * @velocity.x
        y: block.constraint.y * @velocity.y
      block.location.x += @velocity.x * steps
      block.location.y += @velocity.y * steps
      @location.x += @velocity.x * steps
      @location.y += @velocity.y * steps
