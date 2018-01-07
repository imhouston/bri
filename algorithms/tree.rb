class KDTree
  Node = Struct.new(:person, :axis, :left, :right)

  def initialize(persons)
    @dim = persons[0].size
    @root = parse(persons)
  end

  def parse(persons, depth = 0)
    len = persons.size
    axis = depth % @dim

    persons = persons.sort_by{ |person| person[axis] }
    half = len / 2

    left = parse(persons[0...half], depth+1) unless half < 1
    right = parse(persons[half+1...len], depth+1) unless half + 1 >= len

    Node.new(persons[half], axis, left, right)
  end

  def find(query)
    query.each_with_index { |range, i| query[i] = range..range if range.is_a?(Fixnum) }
    @matches = []
    find_by_query(query)
  end

  def find_by_query(current_node = @root, query)
    axis = current_node.axis
    median = current_node.person[axis]
    range = query[axis]

    if current_node.left && (range.nil? || median >= range.begin)
      find_by_query(current_node.left, query)
    end

    if current_node.right && (range.nil? || median <= range.end)
      find_by_query(current_node.right, query)
    end

    @matches << current_node.person if (0..@dim-1).all? { |ax| query[ax].nil? || query[ax] === current_node.person[ax] }
    @matches
  end

  def to_s(node = @root)
    puts node.person

    to_s(node.left) unless node.left.nil?
    to_s(node.right) unless node.right.nil?
  end
end

Person = Struct.new(:age, :salary, :height, :weight)
Rand = Random.new

AGE = 0..100
SALARY = 0..1000000.0
HEIGHT = 0..200
WEIGHT =  0..200

persons = []
10000000.times { persons << Person.new(Rand.rand(AGE), Rand.rand(SALARY), Rand.rand(HEIGHT), Rand.rand(WEIGHT)) }

tree = KDTree.new(persons)

query1 = [nil, 10..20000, nil, 100]

p tree.find(query1).count

#p tree.to_s