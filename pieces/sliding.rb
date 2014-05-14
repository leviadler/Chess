require_relative 'piece'

class SlidingPiece < Piece
  def moves
    possible_moves = []
    
    move_dirs.each do |direction|
      possible_moves += generate_positions(direction)
    end
    
    possible_moves
  end
  
  def generate_positions(direction)
    a, b = direction[0],direction[1]
    x, y = @position.first + a, @position.last + b
    
    positions = []
    
    while in_board?([x,y])
      new_position = [x,y]
      square = @board[new_position]
      
      break if has_ally?(new_position)
      
      positions << new_position
      
      break unless square.nil?
      
      x, y = x + a, y + b
    end
    
    positions
  end
end
