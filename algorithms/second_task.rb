class Stack
  def initialize
    @values = []
  end

  def pop
    @values.pop
  end

  def push(value)
    @values << value
  end

  def top_element
    @values.last
  end

  def to_s
    @values.to_s
  end
end

test_stack = Stack.new
3.times { |i| test_stack.push(i) }
test_stack.pop
p test_stack.top_element
puts test_stack
