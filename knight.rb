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

end

b = Board.new

# puts b.place_nodes.inspect
b.print_board