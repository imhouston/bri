class Counter
  def execute_count(array_a, array_b)
    (array_a + array_b).flatten.inject(Hash.new(0)) do |hash, element|
      hash[element] += 1 unless element.nil?
      hash
    end
  end
end

a = [[4, 19], nil, [32, 41], 65]
b = [234, 0, 21, [54, [4, [4, 4]]]]

puts Counter.new.execute_count(a, b)
