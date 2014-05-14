require_relative 'piece'

class Pawn < Piece
  
  def moves
    forward_directions, side_directions = move_dirs
    possible_moves =[]
    
    side_directions.each do |a,b|
      new_position = [@position[0] + a, @position[1] + b]
      possible_moves << new_position if valid_side_pos?(new_position)
    end 
    
    forward_directions.each do |a,b|
      new_position = [@position[0] + a, @position[1] + b]
      break unless @board[new_position].nil? #stops jumping piece on first move
      possible_moves << new_position
    end 
    possible_moves
  end
  
  def valid_side_pos?(pos)
    in_board?(pos) && has_opponent?(pos)
  end
  
  def move_dirs
    sym = self.color == :w ? -1 : 1  
    forward_directions = [[(sym * 1),0]]
    forward_directions << [(sym * 2),0] if first_move?
    side_directions  = [[(sym * 1),1],[(sym * 1),-1]]
    [forward_directions, side_directions]
  end  
  
  def first_move?
    (self.color == :w && self.position[0] == 6) ||
    (self.color == :b && self.position[0] == 1)
  end
  
  def to_s
    (color == :w) ? "♙" : "♟"
  end
      
  
end
