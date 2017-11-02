# определить, какие точки лежат в окружности с заданным радиусом
class Circle
  def initialize(radius, x_center, y_center)
    @r = radius
    @x_center = x_center
    @y_center = y_center
  end

  def points_in_circle(points_array)
    result_values = []
    points_array.each do |point|
      result_values << point if (point[0] - @x_center)**2 + (point[1] - @y_center)**2 < @r**2
    end

    result_values
  end
end

points = [[10, 10], [20, 20], [2, 3], [4, 4], [62, 57]]

puts Circle.new(6.25, 60.597223, 60.597223).points_in_circle(points)
