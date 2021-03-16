class Node
  attr_accessor :id, :legal_moves, :parent

  def initialize(id)
    @id = id
    @legal_moves = legal_moves
    @parent = @parent
  end
end

class Board
  attr_accessor :board_nodes

  def initialize
    @board_nodes = place_nodes
  end

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



end

b = Board.new

# puts b.place_nodes.inspect
