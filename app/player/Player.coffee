fabric = require("fabric").fabric
_ = require "lodash"

inside = require "../polygon/inside"
intersecting = require "../polygon/intersecting"
input = require "../input"


module.exports = class Player
  constructor: (@location) ->
    @velocity = {x: 0, y: 0}
    @health = 100

  top: -> @location.y - 2
  left: -> @location.x - 2
  bottom: -> @location.y + @health / 2 + 2
  right: -> @location.x + @health / 2 + 2
  center: ->
    x: @location.x + @health / 4
    y: @location.y+ @health / 4

  fabricObject: () ->
    circ = new fabric.Circle
      fill: '#adf'
      top: @location.y
      left: @location.x
      radius: Math.max(@health / 4, 0)
      strokeWidth: 2
      stroke: "#fff"

  updateHealth: (badPolys, veryBadPolys, steps) ->
    # Penalize warmth
    badCount = _.filter(badPolys, (poly) =>
      inside(@center(), poly)
    ).length
    @health -= badCount * steps * .005

    # Penalize direct heat
    veryBadCount = _.filter(veryBadPolys, (poly) =>
      inside(@center(), poly)
    ).length
    @health -= veryBadCount * steps * .1

    # Dead yet?
    if @health < 0
      return true

    false

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
      constraint = block.constraint
      if constraint.x and block.location.x < constraint.x.max
        @velocity.x = constraint.x.ease * @velocity.x
      else
        @velocity.x = 0

      if constraint.y and block.location.y < constraint.y.max
        @velocity.y = constraint.y.ease * @velocity.y
      else
        @velocity.y = 0

      block.location.x += @velocity.x * steps
      block.location.y += @velocity.y * steps

      @location.x += @velocity.x * steps
      @location.y += @velocity.y * steps
