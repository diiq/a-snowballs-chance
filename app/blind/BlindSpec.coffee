Blind = require "./Blind"

describe "Blind", ->
  beforeEach ->
    @blind = new Blind(
      {x: 100, y: 2},
      {x: 100, y: 200}
    )

  it "has a pointA", ->
    expect(@blind.pointA.x).toEqual 100

  it "has a pointB", ->
    expect(@blind.pointB.y).toEqual 200

  it "has a top", ->
    expect(@blind.top).toEqual 2

  it "has a left", ->
    expect(@blind.left).toEqual 100

  it "has a width", ->
    expect(@blind.width).toEqual 3

  it "has a height", ->
    expect(@blind.height).toEqual 198
