# 2015-01-29 Rock/Paper/Scissors Game
require 'pry'


class Driver

  def initialize(p1, p2)
    @p1 = Player.new(p1)
    @p2 = Player.new(p2)
    @p1.score = 0
    @p2.score = 0
  end
  
  def play
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
  
  def new_match(x, p1, p2)
    x.times do
      new_game(p1, p2)
    end
    winner_of_match
  end
  
  def winner_of_match
    if @p1.score > @p2.score
      puts "#{@p1.name} is the winner of the match!"
    elsif @p2.score > @p2.score
      puts "#{@p2.name} is the winner of the match!"
    else
      puts "#{@p1.name} and #{@p2.name} had the same score.  The match is a tie!"
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
      move = gets.chomp.downcase
    end
    player_x.move = (move)
    puts "#{player_x.name} chose #{player_x.move}"
  end
  
  def winner_of_game # public
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