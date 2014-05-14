require "./board"
require "./pieces"
require "./players"

class Game
  
  def initialize(player1, player2)
    @board = Board.new(true)
    player1.color = :w
    player2.color = :b
    @players = [player1, player2]
  end
  
  def play
    
    until @board.over?
      puts @board
      begin
        start_pos, end_pos = @players.first.play_turn
        check_color(start_pos,@players.first)
        @board.move(start_pos, end_pos)
      rescue InvalidMoveError => e
        puts e.message
        retry
      end
      @players.rotate!
    end
    
    
    puts @board
    puts "Checkmate! #{@players.last.name}, you won!"
    
  end
  
  def check_color(pos,player)
    if player.color != @board[pos].color 
      raise InvalidMoveError, "That's not your piece!"
    end
  end
  
end

if __FILE__ == $PROGRAM_NAME
  p1 = HumanPlayer.new("Jack")
  p2 = HumanPlayer.new("Jim")
  
  game = Game.new(p1, p2)
  game.play
  
end