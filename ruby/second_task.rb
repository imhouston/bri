class Circle
  def initialize(radius, x_center, y_center)
    @radius = radius
    @x_center = x_center
    @y_center = y_center
  end

  def include?(point)
    (point.x - @x_center)**2 + (point.y - @y_center)**2 < @radius**2
  end
end

class Point
  attr_accessor :x, :y

  def initialize(x, y)
    self.x = x
    self.y = y
  end

  def coordinates
    [x, y]
  end
end

points = [Point.new(10, 10), Point.new(20, 10), Point.new(2, 3), Point.new(3, 4), Point.new(65, 57)]
circle = Circle.new(6, 1, 2)

points.select { |i| circle.include?(i) }.each { |i| puts i.coordinates }
