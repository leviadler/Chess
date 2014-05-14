require "./board"

class Piece
  attr_reader :color
  attr_accessor :position
  def initialize(color,position,board)
    @board = board
    @position = position
    @color = color
    @board[position] = self
  end
  
  # work in progress
  def dup(new_board)
    self.class.new(self.color,self.position,new_board)
  end
  
  def moves
    raise UnimplementedError
  end
  
  def valid_moves
    self.moves.reject {|move| move_into_check?(move) }
  end
  
  def move_into_check?(pos)
    new_board = @board.dup
    new_board.move!(self.position, pos)
    new_board.in_check?(self.color)
  end
  
  def in_board?(position)
    position.all? {|coord| (coord >= 0) && (coord < 8) }
  end 
  
  def has_ally?(pos)
    !@board[pos].nil? && @board[pos].color == self.color
  end
  
  def has_opponent?(pos)
    !@board[pos].nil? && @board[pos].color != self.color
  end
  
  
end