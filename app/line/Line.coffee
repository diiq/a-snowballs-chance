module.exports = class Line
  constructor: (@pointA, @pointB) ->
    @x = @pointA.x
    @y = @pointA.y
    # Non-normalized derivatives w/ respect to T
    @dx = @pointB.x - @pointA.x
    @dy = @pointB.y - @pointA.y

  intersection: (ray) ->
    # Intersect this line segment with a ray.
    # http://ncase.me/sight-and-light/

    T = ((ray.dx * (@y - ray.y) +
          ray.dy * (ray.x - @x)) /
           (@dx * ray.dy -
            @dy * ray.dx))

    rayT = (@x + @dx * T - ray.x) / ray.dx
    if isNaN(rayT)
      rayT = (@y + @dy * T - ray.y) / ray.dy

    if rayT < 0 or T < 0 or T > 1
      return false

    {
      x: @x + @dx * T,
      y: @y + @dy * T,
      rayT: rayT
    }

  rayCastingPoints: () ->
    # We want points at each end of the line segment, as well as *just
    # past* each end of the line segment. Those will be glancing rays
    # and will define the edge of this segment's shadow.
    [
      @pointA,
      @pointB,
      {
        x: @x + @dx * -.001,
        y: @y + @dy * -.001
      },
      {
        x: @x + @dx * 1.001,
        y: @y + @dy * 1.001
      }
    ]
