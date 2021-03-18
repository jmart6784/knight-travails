class Node
  attr_accessor :id, :legal_moves, :parent

  def initialize(id, legal_moves = [])
    @id = id
    @legal_moves = legal_moves
    @parent = @parent
  end
end

class Board
  attr_accessor :board_nodes

  KNIGHT_MOVE_SET = [
    [2, 1], [2, -1], 
    [-2, 1], [-2, -1], 
    [1, 2], [1, -2], 
    [-1, 2], [-1, -2] 
  ]

  def initialize
    @board_nodes = place_nodes

    # Give each board node their possible moves when the king piece is on
    @board_nodes.each do |node|
      KNIGHT_MOVE_SET.each do |move|
        get_legal_moves(move[0], move[1], node)
      end
    end
  end

  # Populate board with nodes
  def place_nodes
    x = 0
    y = 0
    nodes = []

    64.times do
      id = [x, y]

      nodes << Node.new(id)

      if y < 7
        y += 1
      else
        x += 1
        y = 0
      end
    end
    nodes
  end

  def print_board
    i = 0
    r = 0
    row = ""
    puts_order = []

    72.times do

      unless @board_nodes[i].nil?

        puts_order << "#{row}#{@board_nodes[i].id}" if i === 63

        if r <= 7
          row += r === 7 ? "#{@board_nodes[i].id}" : "#{@board_nodes[i].id}-+-"
          i += 1
          r += 1
        else
          puts_order << row
          row = ""
          r = 0
        end
      end

    end

    i = puts_order.length

    until i === 0
      i -= 1
      puts puts_order[i]
    end

  end

  def get_node(id)
    @board_nodes.each { |node| return node if node.id === id }
  end

  # Check all legal knight moves a node has
  def get_legal_moves(x, y, node)
    condition = node.id[0] + x > 7 || 
                node.id[0] + x < 0 || 
                node.id[1] + y > 7 || 
                node.id[1] + y < 0

    unless condition
      node.legal_moves << [node.id[0] + x, node.id[1] + y]
    end
  end

  def bfs(id = [0, 0])
    history = []
    queue = [id]
    parents = [id]

    until queue.empty?
      if history.include?(queue.first)
        queue.shift 
      else
        get_node(queue.first).legal_moves.each do |move|
          # Add parent node
          get_node(move).parent = queue.first unless parents.include?(move)
          parents << move
          queue << move
        end

        history << queue.first
        queue.shift
      end
    end

    history
  end

  def knight_moves(start_node, end_node)
    bfs(start_node)
    move_path = [end_node]
    current = get_node(end_node)

    until current.id == start_node
      current = get_node(current.parent)
      move_path << current.id
    end
    move_path.reverse
  end 

end

b = Board.new

path = b.knight_moves([3,3],[4,3])

puts "You made it in #{path.length} moves! Here's your path:"

path.each { |move| puts move.inspect }