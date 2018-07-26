=begin
  CREATED: Brandon Brown 2/14/2018
    
  Description: The file contains a test plan for the game.rb class, which
  will test the inteilization of the object.
=end

require "../lib/game.rb"
require 'date'
require "minitest/autorun"


class TestGame < MiniTest::Test

  def setup 
    date = Date.new 2019,4,1
    @game_one = Game.new date, "OSU", "Michigan"
    date = Date.new 2018,2,1
    @game_two = Game.new date, "Toledo", "Toledo"
  end

=begin 
  CREATED: Brandon Brown 2/14/2018
  
  Description: Checks to see if initialize method worked for date of game.
=end
  def test_game_date_initialize
    date = Date.new 2019,4,1
    assert_equal date, @game_one.date
  end 

=begin 
  CREATED: Brandon Brown 2/19/2018
  
  Descritption: Checks initialization of game object date
=end
  def test_game_date_initiailize_two
    date = Date.new 2018,2,1 
    assert_equal date, @game_two.date
  end

=begin
  CREATED: Brandon Brown 2/14/2018
 
  Description: Check initialization of game class location.
=end
  def test_game_location_initialize
    assert_equal "OSU", @game_one.location
  end

=begin
  CREATED: Brandon Brwon 2/19/2018

  Description: Checks initialization of game class location.
=end
  def test_game_initialize_location_two
    assert_equal "Toledo", @game_two.location
  end

=begin
  CREATED: Brandon Brown 2/14/2018 

  Description: Check initialization of game class opponent.
=end 
  def test_game_opponent_initialize
    assert_equal "Michigan", @game_one.opponent
  end

=begin
  CREATED: Brandon Brown 2/19/2018 

  Description: Check initialization of game class opponent.
=end
  def test_game_initialize_opponent_two
    assert_equal "Toledo", @game_two.opponent
  end 

=begin
  CREATED: Brandon Brown 2/14/2018

  Description: Check initialization of game class game winner.
=end
  def test_game_game_won_initialize
    assert_equal "", @game_one.game_result
  end

=begin
  CREATED: Brandon Brown 2/19/2018

  Description: Check initialization of game class game winner.
=end
  def test_game_initialize_winner_two
    assert_equal "", @game_two.game_result
  end

=begin
  CREATED: Brandon Brown 2/14/2018

  Description: Check initialization of game class OSU score.
=end
  def test_game_score_osu_initialize
    assert_nil @game_one.score_osu
  end

=begin
  CREATED: Brandon Brown 2/19/2018

  Description: Check initialization of game class OSU score.
=end
  def test_game_score_osu_initialize_two
    assert_nil @game_one.score_osu
  end

=begin
  CREATED: Brandon Brown 2/14/2018
  Description: Check initialization of game class opponent score.
=end
  def test_game_score_opponent_initialize
    assert_nil @game_one.score_opponent
  end

=begin
  CREATED: Brandon Brown 2/19/2018

  Description: Check initialization of game class opponent score.
=end
  def test_game_score_opponent_initialize_two
    assert_nil @game_two.score_opponent
  end

=begin
  CREATED: Brandon Brown 2/14/2018

  Description: Check game class method for game completed (Return false)
=end
  def test_game_completed_false
    assert_equal false, @game_one.completed?
  end

=begin
  CREATED: Brandon Brown 2/17/2018
  
  Description: Check game class method for game completed (Return true)
=end
  def test_game_completed_true
    assert_equal true, @game_two.completed?
  end
end
