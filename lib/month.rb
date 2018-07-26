=begin
  CREATED: David Levine 2/13/2018
  MODIFIED: Sam Wolfe 2/17/2018
    -Added "update_record" function
    
  Description: The following file contains definitions for a month
  class, which will be used to contain all game objects for a certain month.
=end

class Month

=begin
  CREATED: David Levine 2/13/2018
  MODIFIED: Henry Karagory 2/15/2018
    - Changed the attribute @month to @name to hold the name of the month.
  MODIFIED: Sam Wolfe 2/17/2018
    - Added record of wins/losses
 
  Description: The following initialize method will create 
  a game object array holding all games for the current month.

  Parameters:
    month_name is a string with a month_name

  Requires:
    month_name represents a valid month
=end
  def initialize month_name
    @name = month_name
    @game_objects = []
    @wins = 0
    @losses = 0
    @ties = 0
  end

  attr_reader :name, :game_objects, :wins, :losses, :ties


=begin
  CREATED: Sam Wolfe 2/17/2018
  MODIFIED: David Levine 2/18/2018
    -Added updates information to specs 

  Description: This method increments the corresponding counter for each won or lost game

  Parameters:
    -game is the game being evaluated

  Updates: @wins and @losses
=end
  def update_record game
    @wins += 1 if game.game_result == 'W'
    @losses += 1 if game.game_result == 'L'
    @ties += 1 if game.game_result == 'T'
  end

=begin
  CREATED: David Levine 2/13/2018

  Description: The following will take a game parameter and
  add it to the end of the game_objects array.

  Parameters:
    -game is a single game object.

  Requires: 
    -game element's date should come after the last
     game object's date in the game_objects array.

  Updates: @game_objects with game parameter.
=end
  def add_game game
    @game_objects.push game
    update_record game
  end

=begin
  CREATED: Henry Karagory 02/16/2018
  MODIFIED: David Levine 02/20/2018
    -removed explicit return
    -Added returns to specs

  Description: This method calculates total number
  of points in the current Month object based on the winning condition. 
  If win_conditionis 'W' then total number of points in games
  won is returned, if it is 'L' then total number of points in games 
  lost is returned,and if it is 'ALL' then total number
  of points in all games is returned.

  Parameters:
    win_condition: A string describing which games will be 
    counted towards total number of points.  Must be 
    'L', 'W', or 'ALL'

  Returns: total number of points accrued.
=end
  def num_points win_condition
    points = 0
    @game_objects.each do |game|
      points += game.score_osu game_meets_win_cond win_condition, game
    end
    points
  end


=begin
  CREATED: Henry Karagory 02/16/2018
  MODIFIED: David Levine 02/20/2018
    -removed explicit return
    -Added returns to specs

  Description: This method calculates the total
  number of games played in the current Month object
  based on the winning condition. If win_condition
  is 'W' then total number of games won is returned,
  if it is 'L' then total number of games lost is returned,
  and if it is 'ALL' then total number of games played
  is returned.

  Parameters:
    win_condition: A string describing which games will be 
    counted towards total number of games played.  Must be 
    'L', 'W', or 'ALL'

  Returns: the total number of games played based on win condition
=end
  def num_games win_condition
    total_games = 0
    @game_objects.each do |game|
      total_games += 1 if game_meets_win_cond?(win_condition, game)
    end 
    total_games
  end

=begin
  CREATED: Henry Karagory 02/17/2018
  MODIFIED: David Levine 02/20/2018
    -removed explicit return
    -Added returns to specs

  Description:  This method returns an array with 
  the scores for all games played by the current Month
  object based on the win condition parameter which 
  specifies which types of games that will be included in
  the array.

  Parameters:
    win_condition:  A string that determines what
    types of game scores will be included in the 
    returned array.  Must be either 'W', 'L', or 
    'ALL' to specify games that were won, lost or 
    all games
  
  Return: an array consisting of the score of all games based on win parameter.
=end
  def osu_score_array win_condition
    score_array = @game_objects.map{|game| game_meets_win_cond?(win_condition, game) ? game.score_osu.to_i : -1}
    score_array.delete(-1)
    score_array
  end

=begin
  CREATED: Henry Karagory 02/17/2018

  Description:  This method returns an array with 
  the scores for all games played opponents in the current
   Month oject based on the win condition parameter which 
  specifies which types of games that will be included in
  the array.

  Parameters:
    win_condition:  A string that determines what
    types of game scores will be included in the 
    returned array.  Must be either 'W', 'L', or 
    'ALL' to specify games that were won, lost or 
    all games
=end
  def opponent_score_array win_condition 
    if win_condition == 'W'
      win_condition = 'L'
    elsif win_condition == 'L'
      win_condition = 'W'
    end
      
    score_array = @game_objects.map{|game| game_meets_win_cond?(win_condition, game) ? game.score_opponent.to_i : -1}
    score_array.delete(-1)
    return score_array
  end

=begin
  CREATED: Henry Karagory 02/17/2018
  MODIFIED: David Levine 02/20/2018
    -Added return to specs

  Description:  This method returns true if win_condition
  and game.game_result are the same string or if win_condition
  is the string 'ALL'

  Parameters:
    win_condition: A string that is either 'W', 'L', or
    'ALL'.
=end
  def game_meets_win_cond? win_condition, game
    return false if game.game_result == ""
    win_condition=='ALL' || win_condition==game.game_result
  end
end
