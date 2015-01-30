# 2015-01-29 Rock/Paper/Scissors Game


# Intro
puts "Welcome to Sky's Rock/Paper/Scissors Game!  This is for two players, and winner takes all."


class Driver
  #This class should pull everything to run your program instance
  
  
  def new_game(*players)
    rps = RockPaperScissors.new(players)
  end
  
  def new_match(number_of_games, *players)
    x = number_of_games
    for 1..x do
      new_game(players)
    end
    # @who_is_playing_match = Hash.new
    # @who_is_playing_game.each |player| do
    #   @who_is_playing_match[player] = 0
    # end
  end
  
  def winner_of_match
    # Compare games to determine overall winners of the match
  end
  
  def format_output
    # Self explanatory
  end
  
  
end


class Player
  
  attr_accessor :name, :score, :move
  
  def initialize(name)
    @name = name
    @move = ""
    @score = 0
  end
end

class RockPaperScissors
  
  attr_accessor :games_played, :winner
  
  def initialize(*players)
    @games_played = 0
    @who_is_playing_game = Arary.new
    rules_of_game
    @winner = ""
  end
  
  def rules_of_game
    rules = Hash.new
    rules {"Rock" => "Scissors", "Paper" => "Rock", "Scissors" => "Paper"}
  end

  def capture_player_moves
    @who_is_playing_game.each do |x|
      player_move(x)
    end
  end

  def player_move(player_x)
    move = ""
    while rules.has_key?(move) = false do
      puts "Player #{player_x}, choose your move (Rock, Paper, Scissors): "
      move = gets.chomp
    end
    for player_x.name do
      player_x.move = move
    end
  end
  
  def winner_of_game
    if rules[@who_is_playing[0].move] == @who_is_player[1].move
      @winner = @who_is_playing[0]
    elsif  rules[@who_is_playing[1].move] == @who_is_player[0].move
      @winner = @who_is_playing[1]
    else
      @winner = "Tie"
    end
  end
  

  

end