=begin
  CREATED: David Levine 2/13/2018

  The following file contains a test plan for the month.rb class, which
  will test the successful initalization of the object along with the
  add_game method
=end

require "minitest/autorun"
require_relative "../lib/month.rb"
require_relative "../lib/game.rb"
require 'date'

class TestMonth < Minitest::Test
  
  def setup
    @month_test = Month.new "February"
  end

=begin
  CREATED: David Levine 2/13/2018

  Description: checks to see if initialize method worked
  with the month "February as defined in the setup method
  above
=end
  def test_successful_initialization
    expected_month = "February"
    expected_array_size = 0
    assert_equal expected_month, @month_test.name
    assert_equal expected_array_size, @month_test.game_objects.length
  end

=begin
  CREATED: David Levine 2/13/2018

  Description: checks to see if the initialization class works with
  the March class.
=end
  def test_successful_initialization_different_month
    @month_test = Month.new "March"
    expected_month = "March"
    expected_array_size = 0
    assert_equal expected_month, @month_test.name
    assert_equal expected_array_size, @month_test.game_objects.length
  end
  
=begin
  CREATED: David Levine 2/13/2018
  MODIFED: David Levine 2/16/2018
    -finished the method after finalizing the game class.

  Description: checks to see if the add_game method works
  when adding a game to the empty game_objects array
=end
  def test_add_game_empty
    expected_array_size = 1
    expected_date = Date.new 2001,2,3
    expected_location = "campus"
    expected_opponent = "Michigan"
    
    expected_game = Game.new expected_date, expected_location, expected_opponent

    @month_test.add_game expected_game
  
    #check that the array is 1 (added an element to an array)
    assert_equal expected_array_size, @month_test.game_objects.length
    added_element = @month_test.game_objects[expected_array_size - 1]
    
    #check that a unique (not alliased) game object was added with the same attributes
    refute_match expected_game.object_id, added_element.object_id
    assert_equal expected_game.date, added_element.date
    assert_equal expected_game.location, added_element.location
    assert_equal expected_game.opponent, added_element.opponent
  end

=begin
  CREATED: David Levine 2/16/2018

  Description: checks to see if the add_game method works
  when adding a game to a non-empty game_objects array
=end
  def test_add_game_nonempty
    expected_array_size = 2
    
    #game object 1
    first_date = Date.new 2001,2,3
    first_location = "campus"
    first_opponent = "Michigan"
    first_game = Game.new first_date, first_location, first_opponent    

    #game object 2
    second_date = Date.new 2018,2,16
    second_location = "Kansas"
    second_opponent = "Kansas State University"
    second_game = Game.new second_date, second_location, second_opponent

    @month_test.add_game first_game
    @month_test.add_game second_game
  
    #check that the array is 1 (added an element to an array)
    assert_equal expected_array_size, @month_test.game_objects.length
    second_added_element = @month_test.game_objects[expected_array_size - 1]
    first_added_element = @month_test.game_objects[expected_array_size - 2]
    
    #check that second game added was a unique (not alliased) game object
    #with the same attributes as the original object
    refute_match second_game.object_id, second_added_element.object_id
    assert_equal second_game.date, second_added_element.date
    assert_equal second_game.location, second_added_element.location
    assert_equal second_game.opponent, second_added_element.opponent

    #check that first game added was a unique (not alliased) game object
    #with the same attributes as the original object
    refute_match first_game.object_id, first_added_element.object_id
    assert_equal first_game.date, first_added_element.date
    assert_equal first_game.location, first_added_element.location
    assert_equal first_game.opponent, first_added_element.opponent
  end
 
end
