require_relative "steping"

class Knight < SteppingPiece
  
  def move_dirs
    [[ 2, 1], [ 2, -1],
     [-2, 1], [-2, -1],
     [ 1, 2], [ 1, -2],
     [-1, 2], [-1, -2]]
  end
  
  def to_s
    (color == :w) ? "♘" : "♞"
  end
  
end