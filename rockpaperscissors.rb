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
  
  # Private: initialize
  #
  # Creates two players for use in games
  #
  # Parameters:
  # p1 - String: Name of Player1
  # p2 - Strgin: Name of Player2
  #
  # Returns:
  # New Driver instance
  #
  # State Changes:
  # @p1 and @p2 now point to Player objects
  
  def initialize(p1, p2)
    @p1 = Player.new(p1)
    @p2 = Player.new(p2)
  end
  
  # Public: play
  #
  # Begins playing a match of RPS with each of the Player objects.
  #
  # Parameters: None.
  #
  # Returns:
  # Indirect: A win/tie string.
  # Direct: An end of match string.
  #
  # State Changes: None.
  
  def play
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
  
  # Private: new_game
  #
  # Creates a game and determines a winner (or a tie).
  #
  # Parameters:
  # p1 - Object: Player1 object.
  # p2 - Object: Player2 object.
  #
  # Returns:
  # A win/tie statement string.
  #
  # State Changes:
  # Stores a tie or winning player string in local variable x
  
  def new_game(p1, p2)
    rps = RockPaperScissors.new(p1, p2)
    rps.capture_player_moves
    x = rps.winner_of_game
    if x != "Tie"
      puts "The winner of the game is #{x}!"
    else
      puts "It was a tie!"
    end
  end
  
  # Private: new_match
  #
  # Creates several games of RPS.
  #
  # Parameters:
  # x   - Integer: Number of games or RPS to be played.
  # p1  - Object: Player1 object.
  # p2  - Object: Player2 object.
  #
  # Returns:
  # Indirect: A win/tie statement string for the match.
  #
  # State Changes: None.
  
  def new_match(x, p1, p2)
    x.times do
      new_game(p1, p2)
    end
    winner_of_match
  end
  
  # Private: winner_of_match
  #
  # Determines the overall match winner, by Player score
  #
  # Parameters: None.
  #
  # Returns:
  # A win/tie statement string for the match.
  #
  # State Changes: None.
  
  def winner_of_match
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
# Public Methods: None.

class Player
  
  attr_accessor :name, :move, :score

  # Private: initalize
  #
  # Creates an instance of the Player class.
  #
  # Parameters:
  # name - String: Name of the player
  #
  # Returns:
  # A new player object
  #
  # State Changes:
  # @name will store the player's name; creates @move to store the player's moves
  # creates @score to store the player's score
    
  def initialize(name)
    @name = name
    @move = ""
    @score = 0
  end

end

# Class: RockPaperScissors
#
# For playing games of Rock, Paper, Scissors.
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
  
  # Private: initialize
  #
  # Creates a new RockPaperScissors instance.
  #
  # Parameters:
  # p1 - Object: The Player1 object.
  # p2 - Object: The Player2 object.
  #
  # Returns:
  # The RockPaperScissors object.
  #
  # State Changes:
  # @p1 and @p2 refer to the Player objects; @rules is initialized for comparing player moves;
  # @winner is created to store the name of the winning player.
  
  def initialize(p1, p2)
    @p1 = p1
    @p2 = p2
    @rules = {"rock" => "scissors", "paper" => "rock", "scissors" => "paper"}
    @winner = ""
  end
  
  # Public: capture_player_moves
  #
  # Obtains a move for each player.
  #
  # Parameters: None.
  #
  # Returns:
  # Indirect: The string displaying the player's move choice.
  #
  # State Changes: None.
  
  def capture_player_moves
    player_move(@p1)
    player_move(@p2)
  end
  
  # Private: player_move
  #
  # Determines a move for a player.
  #
  # Parameters:
  # player_x - Object: The Player object.
  #
  # Returns:
  # The string displaying the player's move choice.
  #
  # State Changes:
  # Captures the choice from the player into the move variable, then converts the Player
  # object's @move attribute to the same.
  
  def player_move(player_x)
    move = ""
    while @rules.has_key?(move) == false do
      puts "#{player_x.name}, choose your move (Rock, Paper, Scissors): "
      move = gets.chomp.downcase
    end
    player_x.move = (move)
    puts "#{player_x.name} chose #{player_x.move}"
  end
  
  # Public: winner_of_game
  #
  # Determines a winner of the RPS game.
  #
  # Parameters: None.
  #
  # Returns:
  # A "Tie" string or a string of the winning player's name.
  #
  # State Changes:
  # @winner is set to either "Tie" or the winning player's name.
  
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