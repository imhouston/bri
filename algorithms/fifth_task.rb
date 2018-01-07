require 'benchmark'

TreeNode = Struct.new(:value, :left_node, :right_node)

class MyBinaryTree

  def initialize
    @root = TreeNode.new(nil, nil, nil)
  end

  def Add(value)
    if @root.value.nil?
      @root.value = value
    else
      AddToTree(value)
    end
  end

  private def AddToTree(current_node = @root, value)
    if value.salary < current_node.value.salary
      if current_node.left_node.nil?
        current_node.left_node = TreeNode.new(value, nil, nil)
      else
        AddToTree(current_node.left_node, value)
      end
    else
      if current_node.right_node.nil?
        current_node.right_node = TreeNode.new(value, nil, nil)
      else
        AddToTree(current_node.right_node, value)
      end
    end
  end

  def search(query, current_node = @root, matches = [])
    matches << current_node.value if match?(current_node, query)

    search(query, current_node.left_node, matches) unless current_node.left_node.nil?
    search(query, current_node.right_node, matches) unless current_node.right_node.nil?

    matches
  end

  def match?(node, query)
    query.each_with_index do |value, index|
      if value.is_a?(Range)
        return nil unless value === node.value[index]
      elsif value.is_a?(Fixnum)
        return nil unless value == node.value[index]
      end
    end

    true
  end

  def show_tree(current_node = @root)
    p current_node.value

    show_tree(current_node.left_node) unless current_node.left_node.nil?
    show_tree(current_node.right_node) unless current_node.right_node.nil?
  end
end

Person = Struct.new(:age, :salary, :height, :weight)
Rand = Random.new

AGE = 0..100
SALARY = 0..1000000.0
HEIGHT = 0..200
WEIGHT =  0..200

tree = MyBinaryTree.new
#10_000_000.times { }
10_000_000.times { tree.Add(Person.new(Rand.rand(AGE), Rand.rand(SALARY), Rand.rand(HEIGHT), Rand.rand(WEIGHT))) }
#tree.Add(Person.new(100, 50000, 33, 100))

#tree.show_tree

query1 = [nil, nil, nil, nil]
query2 = [nil, 1000..500000, nil, 100]

Benchmark.bmbm do |x|
  x.report("query 1") { p tree.search(query1).count }
  x.report("query 2") { p tree.search(query2).count }
end

=begin
query1 = [nil, nil, nil, nil]
p tree.search(query1).count

query2 = [nil, 1000..500000, nil, 100]
p tree.search(query2).count
=end

