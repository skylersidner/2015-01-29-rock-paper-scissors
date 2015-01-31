# 2015-01-29 Rock/Paper/Scissors Game
require 'pry'


class Driver

  def initialize
    @list_of_players = Hash.new
  end
  
  
  def new_game(p1, p2)
    rps = RockPaperScissors.new(p1, p2)
    rps.capture_player_moves
    rps.winner_of_game
  end
  
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
  
  attr_accessor :name, :score, :move
  
  def initialize(name)
    @name = name
    @move = ""
    @score = 0
  end
end

class RockPaperScissors
  

  attr_accessor :games_played, :players, :winner
  
  def initialize(p1, p2)
    @games_played = 0
    @p1 = Player.new(p1)
    @p2 = Player.new(p2)
    @rules = {"Rock" => "Scissors", "Paper" => "Rock", "Scissors" => "Paper"}
    @winner = ""
  end

  def capture_player_moves
    puts "Player 1, choose your move: "
    # YOU WERE WORKING HERE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  end

  def player_move(i, player_x)
    move = ""
    while @rules.has_key?(move) == false do
      puts "Player #{i+1}, choose your move (Rock, Paper, Scissors): "
      move = gets.chomp
    end
    @players[i].move = (move)
    puts "Player #{i+1} chose #{@players[i].move}"
  end
  
  def winner_of_game
    if @rules[@players[0].move] == @players[1].move
      @winner = @players[0]
    elsif  @rules[@players[1].move] == @players[0].move
      @winner = @players[1]
    else
      @winner = "Tie"
    end
    @winner
  end
  
end

drive = Driver.new


binding.pry