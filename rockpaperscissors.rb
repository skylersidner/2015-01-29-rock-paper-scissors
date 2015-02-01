# 2015-01-29 Rock/Paper/Scissors Game
require 'pry'

# Class: Driver
#
# Interface for running the game
#
# Attributes:
# @p1 - Object: Creates a Player1 object
# @p2 - Object: Creates a Player2 object
#
# Public Methods:
# #play

class Driver
  
  # Public: 
  #
  # 
  #
  # Parameters:
  # 
  #
  # Returns:
  # 
  #
  # State Changes:
  # 
  
  def initialize(p1, p2)
    @p1 = Player.new(p1)
    @p2 = Player.new(p2)
  end
  
  # Public: 
  #
  # 
  #
  # Parameters:
  # 
  #
  # Returns:
  # 
  #
  # State Changes:
  # 
  
  def play # public
    @p1.score = 0
    @p2.score = 0
    puts "How many games do you want to play?"
    x = gets.chomp.to_i
    if x < 1
      puts "That's no fun!"
    elsif x == 1
      new_game(@p1, @p2)
    else
      new_match(x, @p1, @p2)
    end
  end
  
  # Public: 
  #
  # 
  #
  # Parameters:
  # 
  #
  # Returns:
  # 
  #
  # State Changes:
  # 
  
  def new_game(p1, p2) # private
    rps = RockPaperScissors.new(p1, p2)
    rps.capture_player_moves
    x = rps.winner_of_game
    if x != "Tie"
      puts "The winner of the game is #{x}!"
    else
      puts "It was a tie!"
    end
  end
  
  # Public: 
  #
  # 
  #
  # Parameters:
  # 
  #
  # Returns:
  # 
  #
  # State Changes:
  # 
  
  def new_match(x, p1, p2) # private
    x.times do
      new_game(p1, p2)
    end
    winner_of_match
  end
  
  def winner_of_match # private
    if @p1.score > @p2.score
      puts "#{@p1.name} is the winner of the match!"
    elsif @p2.score > @p2.score
      puts "#{@p2.name} is the winner of the match!"
    else
      puts "#{@p1.name} and #{@p2.name} had the same score.  The match is a tie!"
    end
  end

end

# Class: Player
#
# Class to store things about each player of the game
#
# Attributes:
# @name   - String: The name of the player.
# @move   - String: The current move the player has chosen for that game.
# @score  - Integer: The player's current score for that match.
#
# Public Methods: None

class Player
  
  attr_accessor :name, :move, :score

  # Public: 
  #
  # 
  #
  # Parameters:
  # 
  #
  # Returns:
  # 
  #
  # State Changes:
  # 
    
  def initialize(name)
    @name = name
    @move = ""
    @score = 0
  end

end

# Class: RockPaperScissors
#
# For playing games of Rock, Paper, Scissors
#
# Attributes:
# @p1     - Object: Refers to the Player1 object created in the Driver class.
# @p2     - Object: Refers to the Player2 object created in the Driver class.
# @rules  - Hash: Value for each key is the loosing choice.
# @winner - String: Tracks the winner of each game, by name.
#
# Public Methods:
# #capture_player_moves
# #winner_of_game

class RockPaperScissors
  
  attr_accessor :games_played, :players, :winner
  
  # Public: 
  #
  # 
  #
  # Parameters:
  # 
  #
  # Returns:
  # 
  #
  # State Changes:
  # 
  
  def initialize(p1, p2)
    @p1 = p1
    @p2 = p2
    @rules = {"rock" => "scissors", "paper" => "rock", "scissors" => "paper"}
    @winner = ""
  end
  
  # Public: 
  #
  # 
  #
  # Parameters:
  # 
  #
  # Returns:
  # 
  #
  # State Changes:
  # 
  
  def capture_player_moves
    player_move(@p1)
    player_move(@p2)
  end
  
  # Public: 
  #
  # 
  #
  # Parameters:
  # 
  #
  # Returns:
  # 
  #
  # State Changes:
  # 
  
  def player_move(player_x)
    move = ""
    while @rules.has_key?(move) == false do
      puts "#{player_x.name}, choose your move (Rock, Paper, Scissors): "
      move = gets.chomp.downcase
    end
    player_x.move = (move)
    puts "#{player_x.name} chose #{player_x.move}"
  end
  
  # Public: 
  #
  # 
  #
  # Parameters:
  # 
  #
  # Returns:
  # 
  #
  # State Changes:
  # 
  
  def winner_of_game
    if @rules[@p1.move] == @p2.move
      @winner = @p1.name
      @p1.score += 1
    elsif  @rules[@p2.move] == @p1.move
      @winner = @p2.name
      @p2.score += 1
    else
      @winner = "Tie"
    end
    @winner
  end
  
end

drive = Driver.new("Sue", "Bob")

binding.pry