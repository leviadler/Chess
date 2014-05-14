# encoding: utf-8
require_relative 'pieces/piece'
require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require_relative 'pieces/queen'
require_relative 'pieces/rook'
require_relative 'pieces/steping'
require_relative 'pieces/sliding'
require "./board"


if __FILE__ == $PROGRAM_NAME
  b = Board.new
  p1 = Pawn.new(:w,[1,1],b)
  #p2 = Pawn.new(:w,[1,1],b)
  #b[[2,2]] = p1
  #b[[1,1]] = p2 
  p p1.moves
  
  
end
