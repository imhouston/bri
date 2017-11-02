class Counter
  def initialize
    @hash = Hash.new(0)
  end

  def execute_count(array)
    array.each do |element|
      if element.class != Array
        @hash[element] += 1 unless element.nil?
      else
        execute_count(element)
      end
    end

    @hash
  end
end

a = [[4, 19], nil, [32, 41], 65]
b = [234, 0, 21, [54, [4, [4, 4]]]]

puts Counter.new.execute_count(a + b)
