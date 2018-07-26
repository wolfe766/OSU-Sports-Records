=begin
  CREATED: Sam Wolfe 2/13/2018
  MODIFIED: Henry Karagory 2/15/2018
    -Added the completed? method and changed the initialize method.
  MODIFIED: David Levine 02/20/2018
    -updated spec information.

  Description: The following file contains definitions for a game
  class, which will be used to contain all information about a game
=end

require 'date'
class Game
  attr_accessor :date, :game_result, :location, :opponent, :time, :score_osu, :score_opponent


=begin
  CREATED: Sam Wolfe 2/13/2018

  MODIFIED: Henry Karagory 2/15/2018
    - Added parameters to the initialize method and removed
      the gender attribute. Added the parameter descriptions.
      Removed the completed attribute.
  MODIFIED: David Levine 2/14/2018
    -updated initalize with parameters and also updated the specs
     with parameter definitions
 
  Description: The following initialize method will initialize
  all values 

  Parameters:
    date: An object of the Date class with year, month, and day attributes.
    location: A string representing where the game was played.
    opponent: A string representing the opponent's name.

=end
  def initialize date, location, opponent
    @date = date
    @location = location
    @opponent = opponent
    @time = ""
    @game_result = ""
    @score_osu = nil
    @score_opponent = nil
  end
  
=begin
  CREATED: Henry Karagory 2/15/2018
  MODIFIED: Henry Karagory 2/18/2018
    -changed implementation so we return true if the game was completed
     false otherwise
  MODIFIED: David Levine 02/18/2018
    -updated specs so that current specs match implementation (description
      talked about returning 1, 0, or -1).
    -added returns information to spec.
  MODIFIED: David Levine 02/25/2018
    - Reverted the method and specs so that completed? returns -1, 0, 1.

  Description: This method returns -1 if the game has been completed, 0 if it occurs today 
  or 1 if the game occurs in the future.

  Returns: -1 if game happened, 0 if game occurs today, 1 if game occured in the past.
=end
  def completed?
    Date.today <=> @date
  end

=begin
  CREATED: Henry Karagory 2/15/2018
  MODIFIED: David Levine 02/20/2018
    -updated specs with return

  Description: This method returns true if the 
  current Game object is a game that was won,
  false in all other cases.

  returns: true or false.
=end
  def win?
    @game_result == 'W'
  end
end
