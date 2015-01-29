# 2015-01-29 Rock/Paper/Scissors Game


# Intro
puts "Welcome to Sky's Rock/Paper/Scissors Game!  This is for two players, and winner takes all."

class Player
  
  attr_accessor :name, :score
  
  def initialize(name)
    @name = name
    @moves = Array.new
    @score = 0
  end
  
  def track_move(move)
    @moves << move
  end
end

class Game
  
  attr_accessor :games_played
  
  def initialize(*players)
    @games_played = 0
    @who_is_playing = Hash.new
    players.each |player| do
      @who_is_playing[player] = 0
    end
    rules_of_game
  end
  
  def rules_of_game
    rules = Hash.new
    rules {"Rock" => "Scissors", "Paper" => "Rock", "Scissors" => "Paper"}
  end
  
  def new_game
    
  end
  
  def player_move
    
  end
  
  def winner_of_game
    
  end
  
  def new_match
    
  end
  
  def winner_of_match
    
  end
  
  def format_output
    
  end
  

end