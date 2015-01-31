# 2015-01-29 Rock/Paper/Scissors Game
require 'pry'


class Driver

  def initialize(p1, p2)
    @p1 = Player.new(p1)
    @p2 = Player.new(p2)
  end
  
  def play
    new_game(@p1, @p2)
    # new_match(@p1, @p2)
  end
  
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
  
  # FIX MEEEEEEEEEEEEEEEEEEE!
  def new_match(number_of_games, *players) # WARNING: this will need to be un-splatted before use
    x = number_of_games
    for x in 1..[x]
      new_game(players)
    end
  end
  
   # FIX MEEEEEEEEEEEEEEEEEEEE!
  def winner_of_match
    rps.players.each do |x|
      puts "#{x}'s choice was #{x.move}."
    end
    if rps.winner == "Tie"
      puts "It was tie game!"
    else
      puts "#{rps.winner} is the winner!"
    end
  end
  
  def format_output
    # Self explanatory
  end
  
  
end


class Player
  
  attr_accessor :name, :move, :score
  
  def initialize(name)
    @name = name
    @move = ""
    @score = 0
  end
end

class RockPaperScissors
  

  attr_accessor :games_played, :players, :winner
  
  def initialize(p1, p2)
    @p1 = p1
    @p2 = p2
    @rules = {"rock" => "scissors", "paper" => "rock", "scissors" => "paper"}
    @winner = ""
  end

  def capture_player_moves # public
    player_move(@p1)
    player_move(@p2)
  end

  def player_move(player_x) # private
    move = ""
    while @rules.has_key?(move) == false do
      puts "#{player_x.name}, choose your move (Rock, Paper, Scissors): "
      move.downcase = gets.chomp
    end
    player_x.move = (move)
    puts "#{player_x.name} chose #{player_x.move}"
  end
  
  def winner_of_game # public
    if @rules[@p1.move] == @p2.move
      @winner = @p1.name
    elsif  @rules[@p2.move] == @p1.move
      @winner = @p2.name
    else
      @winner = "Tie"
    end
    @winner
  end
  
end

drive = Driver.new("Sue", "Bob")


binding.pry