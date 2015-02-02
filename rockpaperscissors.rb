# 2015-01-29 Rock/Paper/Scissors Game
require 'pry'

# Class: Driver
#
# Interface for running the game
#
# Attributes:
# @p1     - Object: Creates a Player1 object
# @p2     - Object: Creates a Player2 object
# @rules  - Object: Nil at creation but anticipates representing a Rules object.
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
    @rules = nil
  end
  
  # Public: #play
  #
  # Begins playing a match of the game with each of the (AI_)Player objects.
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
    choose_game
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
  
  # Private: #choose_game
  #
  # Provides a list of games and captures ruleset for the selection.
  #
  # Parameters: None
  #
  # Returns:
  # The ruleset to be used for the match.
  #
  # State Changes:
  # Captures input into x; converts input into a new Rules objet and puts it into
  # local variable, ruleset.
  
  def choose_game
    x = 0
    until x == 1 || x == 2
      puts "Which game would you like to play?"
      puts "1 - Rock/Paper/Scissors"
      puts "2 - Rock/Paper/Scissors/Lizard/Spock"
      x = gets.chomp.to_i
      if x == 1
        @rules = Rules_RPS.new
      elsif x == 2
        @rules = Rules_RPSLS.new
      else
        puts "That is not a valid choice."
      end
    end
  end
  
  # Private: #determine_winner
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
    p1.acquire_move(@rules)
    p2.acquire_move(@rules)
    @rules.winner_of_game(p1, p2)
  end
  
  # Private: #new_game
  #
  # Creates a game and determines a winner (or a tie).
  #
  # Parameters:
  # p1      - Object: Player1 object.
  # p2      - Object: Player2 object.
  # ruleset - Object: The Rules object for the game.
  #
  # Returns:
  # A win/tie statement string.
  #
  # State Changes:
  # Creates a new Game object, game; stores a tie or winning player string in
  # local variable, x.
  
  def new_game(p1, p2)
    x = determine_winner(p1, p2)
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
  # x       - Integer: Number of games of RPS to be played.
  # p1      - Object: Player1 object.
  # p2      - Object: Player2 object.
  # ruleset - Object: The Rules object for the game.
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
  # Determines the overall match winner, by player score.
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
  # A new Player object.
  #
  # State Changes:
  # @name will store the player's name; creates @move to store the player's moves
  # creates @score to store the player's score.
    
  def initialize(name)
    @name = name
    @move = ""
    @score = 0
  end

  # Public: #acquire_move
  #
  # Captures a valid move from a player.
  #
  # Parameters: None.
  #
  # Returns: 
  # String displaying name of the player and their move.
  #
  # State Changes: 
  # @move captures a valid move input from the player.
  
  def acquire_move(ruleset)
    @move = ""
    while ruleset.valid_moves_list.include?(@move) == false do
      ruleset.valid_moves_list.each do |x|
        puts x.capitalize
      end
      puts "#{@name}, choose your move: "
      @move = gets.chomp.downcase
    end
    puts "#{@name} chose #{@move.capitalize}."
  end
  
end

# Class: AI_Player
#
# Class to store things about each AI player of the game.
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
# #acquire_move

class AI_Player
  
  attr_accessor :name, :move, :score

  # Private: #initalize
  #
  # Creates an instance of the AI_Player class.
  #
  # Parameters:
  # name - String: Name of the player.
  #
  # Returns:
  # A new AI_Player object.
  #
  # State Changes:
  # @name will store the player's name; @move to stores the player's moves;
  # @score to stores the player's score;
    
  def initialize(name)
    @name = name
    @move = ""
    @score = 0
  end
  
  # Public: #acquire_move
  #
  # Generates a valid move for an AI_Player.
  #
  # Parameters: None.
  #
  # Returns: 
  # String displaying name of the player and their move.
  #
  # State Changes: 
  # Creates Random object, prng; generates a random number based on how many valid moves are available for x; uses #translate_move method to convert x into a valid move string and adjusts the @move attribute.
  
  def acquire_move(ruleset)
    prng = Random.new
    number_of_moves = ruleset.valid_moves_list.length
    x = prng.rand(number_of_moves)
    @move = ruleset.valid_moves_list[x-1].downcase
    puts "#{@name} chose #{@move.capitalize}."
  end
  
end

# Class: Rules_RPS
#
# Captures player moves and determines a winner.
#
# Attributes:
# @valid_moves_list - Array: List of moves available to the player; used for validation.
# @rules            - Hash: For comparison of player moves.
# @winner           - String: Captures the winning player's name (or a tie).
#
# Public Methods:
# #winner_of_game

class Rules_RPS
  
  attr_reader :valid_moves_list
  
  # Public: #initialize
  #
  # Creates the necessary attributes for the class to function.
  #
  # Parameters: None.
  #
  # Returns:
  # The Rules_RPS object
  #
  # State Changes:
  # @valid_moves_list becomes an array of valid moves; @rules becomes a hash where
  # each key's value is the choice that looses to that key; @winner becomes a string.
  
  def initialize
    @valid_moves_list = ["rock", "paper", "scissors"]
    @rules = {"rock" => "scissors", "paper" => "rock", "scissors" => "paper"}
    @winner = ""
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

# Class: Rules_RPSLS
#
# Captures player moves and determines a winner.
#
# Attributes:
# @valid_moves_list - Array: List of moves available to the player; used for validation.
# @rules            - Hash: For comparison of player moves.
# @winner           - String: Captures the winning player's name (or a tie).
#
# Public Methods:
# #winner_of_game

class Rules_RPSLS
  
  attr_reader :valid_moves_list
  
  # Public: #initialize
  #
  # Creates the necessary attributes for the class to function.
  #
  # Parameters: None.
  #
  # Returns:
  # The Rules_RPSLS object
  #
  # State Changes:
  # @valid_moves_list becomes an array of valid moves; @rules becomes a hash where
  # each key's value is an array of the choices that loose to that key; @winner becomes
  # a string.
  
  def initialize
    @valid_moves_list = ["rock", "paper", "scissors", "lizard", "spock"]
    @rules = Hash.new
    @rules["rock"] = ["scissors", "lizard"]
    @rules["paper"] = ["spock", "rock"]
    @rules["scissors"] = ["paper", "lizard"]
    @rules["lizard"] = ["paper", "spock"]
    @rules["spock"] = ["rock", "scissors"]
    @winner = ""
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
    if @rules[p1.move].include?(p2.move) == true
      @winner = p1.name
      p1.score += 1
    elsif  @rules[p2.move].include?(p1.move) == true
      @winner = p2.name
      p2.score += 1
    else
      @winner = "Tie"
    end
    @winner
  end
  
end

drive = Driver.new("Sue", "BobAI")

binding.pry