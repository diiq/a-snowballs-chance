Line = require "./Line"

describe "Line", ->
  beforeEach ->
    @line = new Line({x: 10, y: 5}, {x: 20, y: 10})
    @ray = new Line({x: 15, y: 5}, {x: 15, y: 20})

  describe "intersection", ->
    it "Returns a point of intersection if possible", ->
      intersection = @line.intersection(@ray)

      expect(intersection.x).toEqual 15
      expect(intersection.y).toEqual 7.5
      expect(intersection.rayT).toBeCloseTo .1666666

    it "Returns false if there is no intesection", ->
      @ray = new Line({x: 5, y: 5}, {x: 10, y: -20})
      intersection = @line.intersection(@ray)
      expect(intersection).toBeFalsy()

    it "Can handle parallel lines", ->
      @ray = new Line({x: 11, y: 5}, {x: 21, y: 10})
      intersection = @line.intersection(@ray)
      expect(intersection).toBeFalsy()


  it "has ray casting points", ->
    points = @line.rayCastingPoints()

    expect(points[0].x).toEqual 10
    expect(points[1].x).toEqual 20
    expect(points[2].x).toNotEqual 10
    expect(points[2].x).toBeCloseTo 10, .01
    expect(points[3].x).toBeCloseTo 20, .01
