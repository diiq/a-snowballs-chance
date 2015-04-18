Line = require "./Line"

describe "Line", ->
  beforeEach ->
    @line = new Line({x: 10, y: 5}, {x: 20, y: 10})
    @ray = new Line({x: 15, y: 5}, {x: 15, y: 20})

  it "intersects", ->
    console.log @line, @ray
    intersection = @line.intersection(@ray)
    console.log intersection

    expect(intersection.x).toEqual 15
    expect(intersection.y).toEqual 7.5
