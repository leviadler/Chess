require_relative 'piece'

class SteppingPiece < Piece
  
  def moves
    possible_moves = []
    
    move_dirs.each do |a, b| 
      new_position = [@position[0] + a, @position[1] + b]
      possible_moves << new_position if valid_pos?(new_position)
    end
    
    possible_moves
  end
  
  def valid_pos?(pos)
    in_board?(pos) && (has_opponent?(pos) || @board[pos].nil?)
  end
  
end
