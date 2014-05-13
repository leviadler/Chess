require "./pieces"

class Board
  def initialize
    @grid = Array.new(8){Array.new(8)}
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
    7.downto(0) do |x|
      8.times do |y|
        if self[[x,y]].nil?
          print "|#{x}, #{y}| "
          next
        end
        print self[[x,y]].color 
      end
      print "\n"
    end
    
  end
    
  
  
end