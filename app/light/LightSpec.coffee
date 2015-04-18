intersect = require "../polygon/intersect"
Light = require "./Light"
Blind = require "../blind/Blind"
Room = require "../room/Room"


describe "Light", ->
  beforeEach ->
    blinds = [
      new Blind(
        {x: 10, y: 10},
        {x: 20, y: 20}
      )
    ]

    # The Room:
    room = new Room(
      {x: 0, y: 0},
      {x: 100, y: 100}
    )

    @blinds = blinds.concat room.walls

    @light = new Light {x: 99, y: 99}
    @light2 = new Light {x: 1, y: 99}

  it "draws a polygon", ->
    points = @light.litPolygon(@blinds)
    # Four lines per blind, four rayCastingPoints per line:
    expect(points.length).toBe (4 * 4 * @blinds.length)

  it "can be passed to polygon/intersect", ->
    p1 = @light.litPolygon(@blinds)
    p2 = @light2.litPolygon(@blinds)
    intersection = intersect([p1, p2])
    expect(intersection.length).toBe 1
    # not sure how to test this honestly.
