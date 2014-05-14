# encoding: utf-8
require "./pieces"

class Board
  def initialize
    @grid = Array.new(8){Array.new(8)}
    setup_board 
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
    @grid.flatten.each do |piece|
      piece.dup(new_board) unless piece.nil?
    end
    new_board
  end
  
  def to_s
    puts "     a  b  c  d  e  f  g  h"
    puts "     0  1  2  3  4  5  6  7 "  #for debugging
    8.times do |x|
      print "#{x+1} " 
      print "#{x} "    #for debugging
      8.times do |y|
        if self[[x,y]].nil?
          print "[ ]"
          next
        end
        print "[#{self[[x,y]]}]"
      end
      print "\n"
    end
  end
  
  def in_check?(color)
    king_pos = find_king(color)
    other_color = (color == :w ? :b : :w)
    
    opponent_pieces = find_pieces(other_color)
    
    opponent_pieces.each do |piece|
      return true if piece.moves.include?(king_pos)
    end
    
    false
  end
  
  def find_pieces(color)
    @grid.flatten.select do |piece|
      piece.is_a?(Piece) && piece.color == color
    end
  end
  
  def find_king(color)
    @grid.flatten.each do |piece|
      if piece.is_a?(King) && piece.color == color
        return piece.position
      end
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
    raise "No piece to move at #{start}" if empty?(start)
    
    piece = self[start]
    
    raise "Invalid move!" unless piece.moves.include?(end_pos)
    raise "Invalid move into check!" unless piece.valid_moves.include?(end_pos)
    
    self[start] = nil
    self[end_pos] = piece
  end
  
  def checkmate?(color)
    find_pieces(color).each do |piece| 
      if !piece.valid_moves.empty?
        p piece.position
        p piece.valid_moves
      end
    end
    find_pieces(color).all? {|piece| piece.valid_moves.empty? }
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
    Rook.new(color, [row, 0], self)
    Rook.new(color, [row, 7], self)
    
    Knight.new(color, [row, 1], self)
    Knight.new(color, [row, 6], self)
    
    Bishop.new(color, [row, 2], self)
    Bishop.new(color, [row, 5], self)
    
    Queen.new(color, [row, 3], self)
    King.new(color, [row, 4], self)
  end
end


if __FILE__ == $PROGRAM_NAME
  b = Board.new
  #k=King.new(:w,[0,0],b)
  #q=Queen.new(:w,[0,5],b)
  print b
  b.move!([7,3], [2,6])
  print b
  b.move!([1,5], [2,5])
  print b
  b.move!([1,7], [2,7])
  print b
  p b.checkmate?(:b)
end

