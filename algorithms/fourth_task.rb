Node = Struct.new(:node_value, :left_node, :right_node)

class BinaryTree
  def initialize(nodes_count)
    @tree = create_node(nodes_count)
  end

  def create_node(count)
    return if count == 0

    left_nodes_count = count/2
    count -= 1
    right_nodes_count = count - left_nodes_count

    Node.new(rand(20), create_node(left_nodes_count), create_node(right_nodes_count))
  end

  def direct_traversing(node = @tree, &block)
    # Посетить узел
    # Обойти левое поддерево
    # Обойти правое поддерево
    yield node.node_value

    direct_traversing(node.left_node, &block) unless node.left_node.nil?
    direct_traversing(node.right_node, &block) unless node.right_node.nil?
  end

  def inverse_traversing(node = @tree, &block)
    # Обойти левое поддерево
    # Обойти правое поддерево
    # Посетить узел
    inverse_traversing(node.left_node, &block) unless node.left_node.nil?
    inverse_traversing(node.right_node, &block) unless node.right_node.nil?

    yield node.node_value
  end

  def symmetric_traversing(node = @tree, &block)
    # Обойти левое поддерево
    # Посетить узел
    # Обойти правое поддерево
    symmetric_traversing(node.left_node, &block) unless node.left_node.nil?

    yield node.node_value

    symmetric_traversing(node.right_node, &block) unless node.right_node.nil?
  end



end

test_tree = BinaryTree.new(10)

test_tree.direct_traversing { |value| puts value }
p '-------------------------------'
test_tree.inverse_traversing { |value| puts value }
p '-------------------------------'
test_tree.symmetric_traversing { |value| puts value }
p '-------------------------------'