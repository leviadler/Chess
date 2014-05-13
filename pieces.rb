require "./board"
class Piece
  attr_reader :color,:position
  def initialize(color,position,board)
    @board = board
    @position = position
    @color = color
  end
  
  def moves
    raise UnimplementedError
  end
  
  def in_board?(position)
    position.all? {|coord| (coord >= 0) && (coord < 8) }
  end 
  
  def has_ally?(pos)
    !@board[pos].nil? && @board[pos].color == self.color
  end
  
  def has_opponent?(pos)
    !has_ally?(pos)
  end
  
  
end

class SlidingPiece < Piece
  def moves
    directions = move_dirs
    
    possible_moves = []
    directions.each do |direction|
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
      
      x, y = x+a, y+b
    end
    
    positions
  end
end

class SteppingPiece < Piece
  
  def moves
    directions = move_dirs
    
    possible_moves = []
    directions.each do |a,b| 
      new_position = [@position[0] + a, @position[1] + b]
      possible_moves << new_position if valid_pos?(new_position)
    end
    
    possible_moves
  end
  
  def valid_pos?(pos)
    in_board?(pos) && (has_opponent?(pos) || @board[pos].nil?)
  end
  
end

class Bishop < SlidingPiece
 
  def move_dirs
    [[1,1], [-1,-1], [1,-1], [-1,1]]
  end
  
end

class Rook < SlidingPiece
  def move_dirs
    [[0,1], [-1,0], [1,0], [0,-1]]
  end
end

class Queen < SlidingPiece
  
  def move_dirs
    [[1,1], [-1,-1], [1,-1], [-1,1],
    [0,1], [-1,0], [1,0], [0,-1]]
  end
  
end

class Knight < SteppingPiece
  
  def move_dirs
    [[ 2, 1], [ 2, -1],
     [-2, 1], [-2, -1],
     [ 1, 2], [ 1, -2],
     [-1, 2], [-1, -2]]
  end
  
end

class King < SteppingPiece
  
  def move_dirs
    [[1,1], [-1,-1], [1,-1], [-1,1],
    [0,1], [-1,0], [1,0], [0,-1]]
  end
  
end

class Pawn < Piece
  
  def moves
    directions = move_dirs
    possible_positions =[]
    
    directions.each do |a,b|
      new_position = [@position[0] + a, @position[1] + b]
      possible_moves << new_position if valid_pos?(new_position)
    end 
    
    
  end
  
  def move_dirs
    directions = [[1,1],[-1,1],[0,1]]
    directions << [0,2] if first_move?
    directions
  end  
  
end



if __FILE__ == $PROGRAM_NAME
  b = Board.new
  p1 = Queen.new(:b,[0,0],b)
  p2 = King.new(:b,[0,1],b)
  b[[0,0]] = p1
  b[[0,1]] = p2 
  print b
  
  p p1.moves
end