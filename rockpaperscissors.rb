# 2015-01-29 Rock/Paper/Scissors Game


# Intro
puts "Welcome to Sky's Rock/Paper/Scissors Game!  This is for two players, and winner takes all."

class Player(name)
  
  attr_accessor :name, :score
  
  def initialize
    @name = name
    @moves = Array.new
    @score = 0
  end
  
  def track_moves(move)
    @moves << move
  end
end

class Game
  
  attr_accessor :matches_played
  
  def initialize
    @matches_played = 0
  end
  
  def new_game
    
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