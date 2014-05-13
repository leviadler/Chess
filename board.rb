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
  
  def []=(pos,value)
    x,y = pos
    @grid[x][y] = value
  end
  
  def to_s
    puts "     a  b  c  d  e  f  g  h"
    puts "     0  1  2  3  4  5  6  7 "  #for debugging
    7.downto(0) do |x|
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
    
  def setup_board
    setup_pawns(1, :w)
    setup_pawns(6, :b)
    
    setup_back(0, :w)
    setup_back(7, :b)
      
  end
  
  def setup_pawns(row,color)
    @grid[row].each_index do |j|
      self[[row,j]] = Pawn.new(color,[row,j],self)
    end
  end
  
  def setup_back(row, color)
    @grid[row][0] = Rook.new(color, [row, 0], self)
    @grid[row][7] = Rook.new(color, [row, 7], self)
    
    @grid[row][1] = Knight.new(color, [row, 1], self)
    @grid[row][6] = Knight.new(color, [row, 6], self)
    
    @grid[row][2] = Bishop.new(color, [row, 2], self)
    @grid[row][5] = Bishop.new(color, [row, 5], self)
    
    @grid[row][3] = Queen.new(color, [row, 3], self)
    @grid[row][4] = King.new(color, [row, 4], self)
  end
end