=begin
  CREATED: Henry Karagory 2/19/2018

  The following file contains test cases for the Sport class.
=end

require "minitest/autorun"
require 'date'
require_relative "../lib/sport.rb"
require_relative "../lib/game.rb"


class TestStats < Minitest::Test
  
  def setup
  	month_array = Date::MONTHNAMES[1, 3]
    @sport_no_games = Sport.new "football", month_array

    @sport_with_games = Sport.new "football", month_array


  	game_to_add1 = Game.new(Date.new(2018, 03, 2), "Columbus OH", "Iowa")
  	game_to_add1.game_result = "L"
  	game_to_add1.score_osu = 5
  	game_to_add1.score_opponent = 15

  	game_to_add2 = Game.new(Date.new(2018, 01, 21), "Columbus OH", "Michigan")
  	game_to_add2.game_result = "W"
  	game_to_add2.score_osu = 20
  	game_to_add2.score_opponent = 10

  	game_to_add3 = Game.new(Date.new(2018, 02, 14), "Columbus OH", "Michigan")
  	game_to_add3.game_result = "W"
  	game_to_add3.score_osu = 12
  	game_to_add3.score_opponent = 7

  	@sport_with_games.add_game game_to_add1
  	@sport_with_games.add_game game_to_add2
  	@sport_with_games.add_game game_to_add3
  end


=begin
  CREATED: Henry Karagory 2/19/2018

  Description: Tests that a game can be added to a Sport object.
=end  
  def test_add_game 
  	game_to_add = Game.new(Date.new(2018, 01, 19), "Columbus OH", "Michigan")
  	game_to_add.game_result = "W"
  	game_to_add.score_osu = 20
  	game_to_add.score_opponent = 10

  	@sport_no_games.add_game game_to_add
  	assert_equal 1, @sport_no_games.months[0].game_objects.length
  end

=begin
  CREATED: Henry Karagory 2/19/2018

  Description: Tests that the number of wins, losses, and
  the total number of games played is calculated correctly from
  the num_games method.
=end 
  def test_num_games_wins
	assert_equal 2, @sport_with_games.num_games('W')
	assert_equal 1, @sport_with_games.num_games('L')
  	assert_equal 3, @sport_with_games.num_games('ALL')
  end

=begin
  CREATED: Henry Karagory 2/19/2018

  Description: Tests that the total points calculated by osu_total_points
  for all games, for games that were won, and for games that were lost is 
  correct for OSU.
=end 
  def test_osu_total_points
  	total_points_expected_all = 5 + 20 + 12
  	total_points_expected_win = 20 + 12
  	total_points_expected_loss = 5 

  	assert_equal total_points_expected_all, @sport_with_games.osu_total_points('ALL')
  	assert_equal total_points_expected_win, @sport_with_games.osu_total_points('W')
  	assert_equal total_points_expected_loss, @sport_with_games.osu_total_points('L')
  end

=begin
  CREATED: Henry Karagory 2/19/2018

  Description: Tests that the average points calculated by osu_avg_score
  for all games, for games that were won, and for games that were lost is 
  correct for OSU.
=end 
  def test_osu_avg_score
  	avg_score_expected_all = (5 + 20 + 12)/3.0
  	avg_score_expected_win = (20 + 12)/2.0
  	avg_score_expected_loss = 5

  	assert_equal avg_score_expected_all, @sport_with_games.osu_avg_score('ALL')
  	assert_equal avg_score_expected_win, @sport_with_games.osu_avg_score('W')
  	assert_equal avg_score_expected_loss, @sport_with_games.osu_avg_score('L')
  end

=begin
  CREATED: Henry Karagory 2/19/2018

  Description: Tests that the average points calculated by opponent_avg_score
  for all games, for games that were won, and for games that were lost is 
  correct for opponents.
=end 
  def test_opponent_avg_score
  	avg_score_expected_all = (15 + 10 + 7)/3.0
  	avg_score_expected_win = 15
  	avg_score_expected_loss = (10 + 7)/2.0

  	assert_equal avg_score_expected_all, @sport_with_games.opponent_avg_score('ALL')
  	assert_equal avg_score_expected_win, @sport_with_games.opponent_avg_score('W')
  	assert_equal avg_score_expected_loss, @sport_with_games.opponent_avg_score('L')
  end

=begin
  CREATED: Henry Karagory 2/19/2018

  Description: Tests that the average score margin calculated by osu_avg_score_margin
  for all games, for games that were won, and for games that were lost is 
  correct for OSU.
=end 
  def test_osu_avg_score_margin
    avg_score_margin_expected_all = (-10 + 10 + 5)/3.0
    avg_score_margin_expected_win = (10+5)/2.0
    avg_score_margin_expected_loss = -10

    assert_equal avg_score_margin_expected_all, @sport_with_games.osu_avg_score_margin('ALL')
    assert_equal avg_score_margin_expected_win, @sport_with_games.osu_avg_score_margin('W')
    assert_equal avg_score_margin_expected_loss, @sport_with_games.osu_avg_score_margin('L')
  end

=begin
  CREATED: Henry Karagory 2/19/2018

  Description: Tests that the average score margin calculated by opponent_avg_score
  for all games, for games that were won, and for games that were lost is 
  correct for opponents.
=end 
  def test_opponent_avg_score_margin
    avg_score_margin_expected_all = (10 + -10 + -5)/3.0
    avg_score_margin_expected_win = 10
    avg_score_margin_expected_loss = (-10 + -5)/2.0

    assert_equal avg_score_margin_expected_all, @sport_with_games.opponent_avg_score_margin('ALL')
    assert_equal avg_score_margin_expected_win, @sport_with_games.opponent_avg_score_margin('W')
    assert_equal avg_score_margin_expected_loss, @sport_with_games.opponent_avg_score_margin('L')
  end

=begin
  CREATED: Henry Karagory 2/19/2018

  Description: Tests that the score standard deviation calculated by osu_score_std_dev
  for all games, for games that were won, and for games that were lost is 
  correct for OSU.
=end 
  def test_osu_score_std_dev
    std_dev_expected_all = 7.50556
    std_dev_expected_win = 5.6568
    std_dev_expected_loss = 0

    assert_in_delta std_dev_expected_all, @sport_with_games.osu_score_std_dev('ALL'), 0.01
    assert_in_delta std_dev_expected_win, @sport_with_games.osu_score_std_dev('W'), 0.01
    assert_in_delta std_dev_expected_loss, @sport_with_games.osu_score_std_dev('L'), 0.01
  end

=begin
  CREATED: Henry Karagory 2/19/2018

  Description: Tests that the score standard deviation calculated by opponent_score_std_dev
  for all games, for games that were won, and for games that were lost is 
  correct for opponents.
=end 
  def test_opponent_score_std_dev
    std_dev_expected_all =  4.04145
    std_dev_expected_win = 0
    std_dev_expected_loss = 2.1213

    assert_in_delta std_dev_expected_all, @sport_with_games.opponent_score_std_dev('ALL'), 0.01
    assert_in_delta std_dev_expected_win, @sport_with_games.opponent_score_std_dev('W'), 0.01
    assert_in_delta std_dev_expected_loss, @sport_with_games.opponent_score_std_dev('L'), 0.01
  end

=begin
  CREATED: Henry Karagory 2/19/2018

  Description: Tests that the score array returned by osu_score_array
  for all games, for games that were won, and for games that were lost is 
  correct.
=end 
  def test_osu_score_array
    score_array_expected_all =  [5, 20, 12]
    score_array_expected_win = [20, 12]
    score_array_expected_loss = [5]

    assert (score_array_expected_all - @sport_with_games.osu_score_array('ALL')).empty?
    assert (score_array_expected_win - @sport_with_games.osu_score_array('W')).empty?
    assert (score_array_expected_loss - @sport_with_games.osu_score_array('L')).empty?
  end

=begin
  CREATED: Henry Karagory 2/19/2018

  Description: Tests that the score array returned by opponent_score_array
  for all games, for games that were won, and for games that were lost is 
  correct.
=end 
  def test_opponent_score_array
    score_array_expected_all =  [15, 10, 7]
    score_array_expected_win = [15]
    score_array_expected_loss = [10, 7]

    assert (score_array_expected_all - @sport_with_games.opponent_score_array('ALL')).empty?
    assert (score_array_expected_win - @sport_with_games.opponent_score_array('W')).empty?
    assert (score_array_expected_loss - @sport_with_games.opponent_score_array('L')).empty?
  end
end
