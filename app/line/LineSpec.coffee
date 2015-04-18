Line = require "./Line"

describe "Line", ->
  beforeEach ->
    @line = new Line({x: 10, y: 5}, {x: 20, y: 10})
    @ray = new Line({x: 15, y: 5}, {x: 15, y: 20})

  it "intersects", ->
    intersection = @line.intersection(@ray)

    expect(intersection.x).toEqual 15
    expect(intersection.y).toEqual 7.5
    expect(intersection.rayT).toBeCloseTo .1666666

  it "has ray casting points", ->
    points = @line.rayCastingPoints()

    expect(points[0].x).toEqual 10
    expect(points[1].x).toEqual 20
    expect(points[2].x).toNotEqual 10
    expect(points[2].x).toBeCloseTo 10, .01
    expect(points[3].x).toBeCloseTo 20, .01
