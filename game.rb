require "board"
require "pieces"

class Game
  def initialize(player1, player2)
    @board=Board.new(true)
    @players = [player1, player2]
  end
  
  def play
    
    until @board.over?
      begin
        start_pos, end_pos = @players.first.play_turn
        @board.move(start_pos, end_pos)
      rescue InvalidMoveError => e
        puts e.message
        retry
      end
      @players.rotate!
    end
    
  end
  
end