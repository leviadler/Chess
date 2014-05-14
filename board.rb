# encoding: utf-8
require "./pieces"
require "colorize"


class InvalidMoveError < StandardError
end

class Board
  
  BOARD_SIZE = 8
  
  def initialize(setup = false)
    @grid = Array.new(BOARD_SIZE){Array.new(BOARD_SIZE)}
    setup_board if setup
  end 
  
  def [](pos)
    x,y = pos
    @grid[x][y]
  end
  
  def []=(pos,piece)
    x,y = pos
    @grid[x][y] = piece
    piece.position = pos unless piece.nil?
  end
  
  def empty?(pos)
    self[pos].nil?
  end
  
  def dup
    new_board = Board.new
    pieces.each do |piece|
      piece.dup(new_board)
    end
    new_board
  end
  
  def pieces
    @grid.flatten.compact
  end
  
  def render
    system "clear"
    puts "   a  b  c  d  e  f  g  h"
    #puts "     0  1  2  3  4  5  6  7 "  #for debugging
    BOARD_SIZE.times do |x|
      print "#{BOARD_SIZE-x} " 
      #print "#{x} "    #for debugging
      BOARD_SIZE.times do |y|
        str = self[[x,y]].nil? ? "   " : " #{self[[x,y]]} "
        if (x + y).odd?
          print str.colorize( :background => :light_black)
        else
          print str
        end
      end
      print "\n"
    end
  end
  
  def in_check?(color)
    king = find_king(color)
    other_color = (color == :w ? :b : :w)
    
    opponent_pieces = find_pieces(other_color)
    
    opponent_pieces.any? do |piece|
      piece.moves.include?(king.position)
    end
  end
  
  def find_pieces(color)
    pieces.select do |piece|
      piece.color == color
    end
  end
  
  def find_king(color)
    find_pieces(color).find do |piece|
      piece.is_a?(King)
    end
  end
  
  def move!(start, end_pos)
    # no error checking b/c program is passing the params
    piece = self[start]
    self[start] = nil
    self[end_pos] = piece
    self
  end
  
  def move(start, end_pos)
    raise InvalidMoveError, "No piece to move at #{start}" if empty?(start)
    
    piece = self[start]
    
    raise InvalidMoveError, "Invalid move!" unless piece.moves.include?(end_pos)
    raise InvalidMoveError, "Invalid move into check!" unless piece.valid_moves.include?(end_pos)
    
    self[start] = nil
    self[end_pos] = piece
  end
  
  def checkmate?(color)
    find_pieces(color).all? {|piece| piece.valid_moves.empty? }
  end
  
  def over?
    checkmate?(:w) || checkmate?(:b)
  end
  
  protected
  def setup_board
    setup_pawns(6, :w)
    setup_pawns(1, :b)
    
    setup_back(7, :w)
    setup_back(0, :b)
      
  end
  
  def setup_pawns(row,color)
    @grid[row].each_index do |j|
      Pawn.new(color,[row,j],self)
    end
  end
  
  def setup_back(row, color)
    back_row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    
    back_row.each_with_index do |piece, col|
      piece.new(color, [row, col], self)
    end
  end
end


if __FILE__ == $PROGRAM_NAME
  b = Board.new(true)
  #k=King.new(:w,[0,0],b)
  #q=Queen.new(:w,[0,5],b)
  print b
  b.move([7,3], [2,6])
  print b
  b.move!([1,5], [2,5])
  print b
  b.move!([1,7], [2,7])
  print b
  p b.checkmate?(:b)
end

