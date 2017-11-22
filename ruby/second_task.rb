Point = Struct.new(:x, :y)

class Circle
  def initialize(radius, x_center, y_center)
    @radius = radius
    @center = Point.new(x_center, y_center)
  end

  def include?(point)
    (point.x - @center.x)**2 + (point.y - @center.y)**2 < @radius**2
  end
end

points = [Point.new(10, 10), Point.new(20, 10), Point.new(2, 3), Point.new(3, 4), Point.new(65, 57)]
circle = Circle.new(6, 1, 2)

points.select { |i| circle.include?(i) }.each { |i| puts "(#{i.x}, #{i.y})" }
