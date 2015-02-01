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
  
  # Private: #initialize
  #
  # Creates two players for use in games.
  #
  # Parameters:
  # p1 - String: Name of Player1
  # p2 - Strgin: Name of Player2
  #
  # Returns:
  # New Driver instance
  #
  # State Changes:
  # array becomes an array of (AI_)Player objects; @p1 and @p2 now point to (AI_)Player
  # objects.
  
  def initialize(*players)
    array = Array.new
    players.each do |name|
      if name.end_with?("AI")
        array << AI_Player.new(name)
      else
        array << Player.new(name)
      end
    end
    @p1 = array[0]
    @p2 = array[1]
  end
  
  # Public: #play
  #
  # Begins playing a match of RPS with each of the (AI_)Player objects.
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
  
  # Private: #new_game
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
  # Stores a tie or winning player string in local variable x.
  
  def new_game(p1, p2)
    rps = Game.new
    x = rps.determine_winner(p1, p2)
    if x != "Tie"
      puts "The winner of the game is #{x}!"
    else
      puts "It was a tie!"
    end
  end
  
  # Private: #new_match
  #
  # Creates several games of RPS.
  #
  # Parameters:
  # x   - Integer: Number of games of RPS to be played.
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
  
  # Private: #winner_of_match
  #
  # Determines the overall match winner, by player score
  #
  # Parameters: None.
  #
  # Returns:
  # A win/tie statement string for the match.
  #
  # State Changes: None.
  
  def winner_of_match
    puts "#{@p1.name}: #{@p1.score}"
    puts "#{@p2.name}: #{@p2.score}"
    if @p1.score > @p2.score
      puts "#{@p1.name} is the winner of the match!"
    elsif @p2.score > @p1.score
      puts "#{@p2.name} is the winner of the match!"
    else

      puts "#{@p1.name} and #{@p2.name} had the same score.  The match is a tie!"
    end
  end

end

# Class: Player
#
# Class to store things about each player of the game.
#
# Attributes:
# @name   - String: The name of the player.
# @move   - String: The current move the player has chosen for that game.
# @score  - Integer: The player's current score for that match.
#
# Public Methods:
# #name, #name=
# #move, #move=
# #score, #score=

class Player
  
  attr_accessor :name, :move, :score

  # Private: #initalize
  #
  # Creates an instance of the Player class.
  #
  # Parameters:
  # name - String: Name of the player.
  #
  # Returns:
  # A new player object.
  #
  # State Changes:
  # @name will store the player's name; creates @move to store the player's moves
  # creates @score to store the player's score.
    
  def initialize(name)
    @name = name
    @move = ""
    @score = 0
  end

end

# Class: AI_Player
#
# Class to store things about each AI player of the game
#
# Attributes:
# @name   - String: The name of the player.
# @move   - String: The current move the player has chosen for that game.
# @score  - Integer: The player's current score for that match.
#
# Public Methods:
# #name, #name=
# #move, #move=
# #score, #score=
# #create_move

class AI_Player
  
  attr_accessor :name, :move, :score

  # Private: #initalize
  #
  # Creates an instance of the Player class.
  #
  # Parameters:
  # name - String: Name of the player.
  #
  # Returns:
  # A new player object.
  #
  # State Changes:
  # @name will store the player's name; creates @move to store the player's moves;
  # creates @score to store the player's score.
    
  def initialize(name)
    @name = name
    @move = ""
    @score = 0
  end
  
  # Public: #create_move
  #
  # Generates a valid move for an AI_Player.
  #
  # Parameters: None.
  #
  # Returns: 
  # The string just placed into the @move attribute.
  #
  # State Changes: 
  # Creates Random object, prng; generates a random number between 1 and 3 for x;
  # uses #translate_move method to convert x into a valid move string and
  # adjusts the @move attribute.
  
  def create_move
    prng = Random.new
    x = prng.rand(3)
    @move = translate_move(x)
  end
  
  # Private: #translate_move
  #
  # Converts a random number into a valid move string.
  #
  # Parameters: 
  # x - Integer from 1 to 3: Random number generated in #create_move.
  #
  # Returns: 
  # A string based on the Rules_RPS object with the #valid_moves_list accessor.
  #
  # State Changes: None.
  
  def translate_move(x) #private
    rules = Rules_RPS.new
    rules.valid_moves_list[x-1].downcase
  end
  
end

# Class: Game
#
# For playing games of Rock, Paper, Scissors.
#
# Attributes: None.
#
# Public Methods:
# #determine_winner

class Game
  
  # Private: #initialize
  #
  # Creates a new Game instance.
  #
  # Parameters: None.
  #
  # Returns:
  # The Game object.
  #
  # State Changes:
  # @p1 and @p2 refer to the (AI_)Player objects; @rules is initialized for comparing
  # player moves;
  # @winner is created to store the name of the winning player.
  
  def initialize
    
  end
  
  # Public: #determine_winner
  #
  # Captures moves to determine a winner.
  #
  # Parameters:
  # p1 - Object: The Player1 object.
  # p2 - Object: The Player2 object.
  #
  # Returns:
  # Indirect: A string of the winning player's name (or a tie).
  #
  # State Changes: None.
  
  def determine_winner(p1, p2)
    rules = Rules_RPS.new
    rules.player_move(p1)
    rules.player_move(p2)
    rules.winner_of_game(p1, p2)
  end
  
end

# Class: Rules_RPS
#
# Captures player moves and determines a winner.
#
# Attributes:
# @valid_moves_list - Array: List of moves available to the player.
# @rules            - Hash: For boolean comparison of player moves and validation.
# @winner           - String: Captures the winner player's name (or a tie).
#
# Public Methods:
# #valid_moves_list
# #player_move
# #winner_of_game

class Rules_RPS
  
  attr_reader :valid_moves_list
  # Public: #initialize
  #
  # Creates the necessary objects for the class to function.
  #
  # Parameters: None.
  #
  # Returns:
  # The Rules object
  #
  # State Changes:
  # @p1 and @p2 point to the players; @valid_moves_list becomes an array; @rules becomes a hash;
  # @winner becomes a string.
  
  def initialize
    @valid_moves_list = ["Rock", "Paper", "Scissors"]
    @rules = {"rock" => "scissors", "paper" => "rock", "scissors" => "paper"}
    @winner = ""
  end
  
  # Public: #player_move
  #
  # Determines a move for a player.
  #
  # Parameters:
  # player_x - Object: The (AI_)Player object.
  #
  # Returns:
  # The string displaying the player's move choice.
  #
  # State Changes:
  # Captures the choice from the player into the choice variable, then converts the (AI_)Player
  # object's @move attribute to the same.
  
  def player_move(player_x)
    choice = ""
    if player_x.name.end_with?("AI") == true
      choice = player_x.create_move
    else
      while @rules.has_key?(choice) == false do
        @valid_moves_list.each do |x|
          puts x
        end
        puts "#{player_x.name}, choose your move: "
        choice = gets.chomp.downcase
      end
    end
    player_x.move = (choice)
    puts "#{player_x.name} chose #{player_x.move}"
  end
  
  # Public: #winner_of_game
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
  
  def winner_of_game(p1, p2)
    if @rules[p1.move] == p2.move
      @winner = p1.name
      p1.score += 1
    elsif  @rules[p2.move] == p1.move
      @winner = p2.name
      p2.score += 1
    else
      @winner = "Tie"
    end
    @winner
  end
  
end

drive = Driver.new("SueAI", "BobAI")

binding.pry