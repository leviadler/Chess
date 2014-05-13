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
    x, y = x+a, y+b
    
    positions = []
    while (x >= 0 && x < 8) && (y >= 0 && y < 8)
      new_position = [x,y]
      p "new pos"
      p new_position
      unless @board[new_position].nil? 
        unless @board[new_position].color == self.color
          positions << new_position
        end
        break
      end
      positions << new_position
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
      position.all? {|coord| coord >= 0 && coord < 8 }
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
  p2 = Queen.new(:b,[0,5],b)
  b[[0,0]] = p1
  b[[0,5]] = p2 
  print b
  
  p p2.moves
end