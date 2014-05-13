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
    position.all? {|coord| coord >= 0 && coord < 8 }
  end 
  
end

class SlidingPiece < Piece
  def moves
    directions = self.move_dirs
    
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
      
      break if !square.nil? && square.color == self.color
      
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
    
    positions = directions.map  do |a,b|
      [@position[0] + a, @position[1] + b]
    end.select do |possition|
      in_board?(possition)
    end
    
    positions.delete_if do |pos|
      !@board[pos].nil? && @board[pos].color == self.color
    end
    positions
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



if __FILE__ == $PROGRAM_NAME
  b = Board.new
  p1 = Queen.new(:b,[0,0],b)
  p2 = Queen.new(:w,[0,5],b)
  b[[0,0]] = p1
  b[[0,5]] = p2 
  print b
  
  p p2.moves
end