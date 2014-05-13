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
    x,y = @position[0],@position[1]
    a,b = direction[0],direction[1]
    positions = []
    until (x >= 0 && x < 8) && (y >= 0 && y < 8) 
      new_position = [x+a,y+b]
      
      unless @board[new_position].nil? 
        unless @board[new_position].color == self.color
          positions << new_position
        end
        break
      end
      positions << new_position
    end
    
    positions
  end
          
  end
end

class SteppingPiece < Piece
  
  def moves
    direction = move_dirs
    
    positions = directions.map  do |a,b|
      [@position[0] + a, @position[1] + b]
    end.select do |possition|
      position.all? {|coord| coord >= 0 && coord < 8) }
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