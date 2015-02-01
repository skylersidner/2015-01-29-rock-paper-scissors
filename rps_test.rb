require 'minitest/autorun'
require_relative 'rockpaperscissors'

class PlayerTest < Minitest::Test
  
  def test_if_player_name_is_a_string
    player = Player.new("Sue")
    assert_kind_of String, player.name
  end
  
  def test_if_player_move_is_a_string
    player = Player.new("Bob")
    player.move = "Rock"
    assert_kind_of String, player.move
  end
  
  def test_if_player_score_is_not_a_float
    player = Player.new("Bob")
    assert_kind_of Float, player.score
  end
  
  
end