class Player
end

class HumanPlayer < Player
  
  attr_accessor :color, :name
  
  def initialize(name)
    @name = name
    @color = nil
  end
  
  def play_turn
    puts "#{@name}, you are #{color_to_s}."
    puts "Choose the piece you want to move? (ex. f2)"
    start_pos = get_input
    puts "Choose the location you want to move to:"
    end_pos = get_input
    
    [start_pos, end_pos]
  end
  
  def color_to_s
    @color == :w ? "white" : "black"
  end
  
  def get_input
    pos = gets.chomp.split(",").map{ |i| i.to_i }
  end
  
end