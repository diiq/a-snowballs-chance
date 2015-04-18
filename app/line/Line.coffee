module.exports = class Line
  constructor: (@pointA, @pointB) ->
    @x = @pointA.x
    @y = @pointA.y
    # Non-normalized derivatives w/ respect to T
    @dx = @pointB.x - @pointA.x
    @dy = @pointB.y - @pointA.y
    @angle = Math.atan2(@dy, @dx)

  intersection: (ray) ->
    # Intersect this line segment with a ray.
    # http://ncase.me/sight-and-light/
    #if @angle - ray.angle < .01
    #  return false

    T = ((ray.dx * (@y - ray.y) +
          ray.dy * (ray.x - @x)) /
           (@dx * ray.dy -
            @dy * ray.dx))

    rayT = (@x + @dx * T - ray.x) / ray.dx
    if isNaN(rayT)
      rayT = (@y + @dy * T - ray.y) / ray.dy

    x = @x + @dx * T
    y = @y + @dy * T

    if rayT < 0 or T < 0 or T > 1 or T > 10000 or isNaN(T) or isNaN(rayT)
      return false

    {
      x: x
      y: y
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
        x: @x + @dx * -.01,
        y: @y + @dy * -.01
      },
      {
        x: @x + @dx * 1.01,
        y: @y + @dy * 1.01
      }
    ]
