=begin 
  CREATED: Henry Karagory 02/11/2018
  MODIFIED: David Levine 2/20/2018
    -Updated specs with return parameters and deleted
     unused generate_page instance method.

  Description:  This class represents a single 
  sport team and encapsulates information about
  all games played by the team for a number of
  different months.
=end

require_relative './month.rb'
require_relative './stats.rb'
require_relative './page_generator.rb'
require 'matrix'

class Sport 
  attr_accessor :name, :months

=begin
  CREATED: Henry Karagory 02/11/2018
  MODIFIED: David Levine 02/20/2018
    -Added return information to the specs
    -removed explicit return from method

  Description: This method initializes a new
  Sport object with a string name attribute 
  and an array of Month objects attribute to
  keep track of months in which games of the 
  given sport occurred.

  Parameters:
    name: A string representing the name of the 
    sport team.
    months: An array of strings that are each the
    name of a month in which a game of the given
    sport occurred.

  Updates:
    sets @name to the name given

    updates @months so the array contains every month string passed in
    from the month array.
=end
  def initialize name, months_name_array
    @name = name
    @months = []

    months_name_array.each do |month_name|
      @months << (Month.new month_name)
    end
  end

=begin
  CREATED: Henry Karagory 02/11/2018
  MODIFIED: Henry Karagory 02/15/2018
    - changed game.month to game.date.month

  Description: This method adds a 
  Game object, game, to the current
  Sport object by adding the parameter 
  game to the correct Month in the 
  @months array.

  Parameters: 
    game: The Game object to be added
    to the appropriate Month object in
    the @months array.
=end
  def add_game game
    @months.each do |month|
      month.add_game game if month.name == Date::MONTHNAMES[game.date.month]
    end
  end

=begin
  CREATED: Henry Karagory 02/16/2018
  MODIFIED: David Levine 02/20/2018
    -Added return information to the specs

  Description: This method calculates the total
  number of games played by the current Sport
  object based on the win_condition parameter
  which specifies what types of game will
  be counted towards the total number of games
  played.

  Parameters:
    win_condition: A string that determines 
    which types of games will be counted towards
    thte total number of games played.  Must be
    either 'W', 'L', or 'ALL' to specify games 
    that were won, lost, or all games.

  Returns: an integer representing the total games played
=end
  def num_games win_condition
    total_games = 0
    @months.each do |month|
      total_games += month.num_games(win_condition)
    end
    total_games
  end

=begin
  CREATED: Henry Karagory 02/17/2018
  MODIFIED: David Levine 02/20/2018
    -Added return information to the specs

  Description: This method calculates the total 
  number of points scored by the current Sport
  obect based on the win_condition parameter
  which specifies what types of game will
  be counted towards the total points.

  Parameters:
    win_condition: A string that determines 
    which types of games will be counted towards
    the total points.  Must be either 'W', 'L', 
    or 'ALL' to specify games that were won, lost, 
    or all games.
=end
  def osu_total_points win_condition
    score_array = osu_score_array win_condition
    Stats.sum score_array
  end


=begin
  CREATED: Henry Karagory 02/16/2018
  MODIFIED: David Levine 02/20/2018
    -Added return information to the specs

  Description: This method calculates the average score
  for all games played by the current Sport object
  based on the win_condition parameter which specifies
  what types of game will be used to calculate the
  average score.

  Parameters:
    win_condition: A string that determines 
    which types of games will be used to calculate
    the average score.  Must be either 'W', 'L', 
    or 'ALL' to specify games that were won, lost, 
    or all games.

   Returns: a float value represneting OSU's average score.
=end
  def osu_avg_score win_condition
    score_array = osu_score_array win_condition
    Stats.average score_array
  end

=begin
  CREATED: Henry Karagory 02/16/2018
  MODIFIED: David Levine 02/20/2018
    -Added return information to the specs

  Description: This method calculates the average score
  for all games played by opponents of the current Sport object
  based on the win_condition parameter which specifies
  what types of game will be used to calculate the
  average score.

  Parameters:
    win_condition: A string that determines 
    which types of games will be used to calculate
    the average score.  Must be either 'W', 'L', 
    or 'ALL' to specify games that were won, lost, 
    or all games.

  Returns: A float value representing a given opponent's average score
=end
  def opponent_avg_score win_condition
    score_array = opponent_score_array win_condition
    Stats.average score_array
  end

=begin
  CREATED: Henry Karagory 02/17/2018
  MODIFIED: David Levine 02/20/2018
    -Added return information to the specs

  Description: This method calculates the average score margin
  for all games played by the current Sport object
  based on the win_condition parameter which specifies
  what types of game will be used to calculate the
  average score margin. This is always returned as
  a positive number.

  Parameters:
    win_condition: A string that determines 
    which types of games will be used to calculate
    the average score margin.  Must be either
    'W', 'L', or 'ALL' to specify games that were 
    won, lost, or all games.

    Returns: A float value representing OSU's average score margin.
=end
  def osu_avg_score_margin win_condition_osu
    score_array = osu_score_array win_condition_osu

    # Ensure that the right win codition is being apssed to get the opponent score array.
    opp_win_condition = win_condition_osu
    if win_condition_osu == 'W'
      opp_win_condition = 'L'
    elsif win_condition_osu == 'L'
      opp_win_condition = 'W'
    end

    opp_score_array = opponent_score_array opp_win_condition
    difference = (Matrix[score_array] - Matrix[opp_score_array]).to_a[0]
    Stats.average difference
  end

=begin
  CREATED: Henry Karagory 02/17/2018
  MODIFIED: David Levine 02/20/2018
    -Added return information to the specs

  Description: This method calculates the average score margin
  for all games played opponents of the current Sport object
  based on the win_condition parameter which specifies
  what types of game will be used to calculate the
  average score margin. This is always returned as
  a positive number.

  Parameters:
    win_condition: A string that determines 
    which types of games will be used to calculate
    the average score margin.  Must be either
    'W', 'L', or 'ALL' to specify games that were 
    won, lost, or all games.

  Returns: A float value representing an opponents average score margin
=end
  def opponent_avg_score_margin win_condition_opp
    # Ensure that the right win codition is being apssed to get the opponent score array.
    win_condition_osu = win_condition_opp
    if win_condition_opp == 'W'
      win_condition_osu = 'L'
    elsif win_condition_opp == 'L'
      win_condition_osu = 'W'
    end

    score_array = opponent_score_array win_condition_opp
    ohio_score_array = osu_score_array win_condition_osu

    difference = (Matrix[score_array] - Matrix[ohio_score_array]).to_a[0]
    Stats.average difference
  end

=begin
  CREATED: Henry Karagory 02/17/2018
  MODIFIED: David Levine 02/20/2018
    -Added return information to the specs

  Description: This method calculates the standard deviation
  for all games played by the current Sport object
  based on the win_condition parameter which specifies
  what types of game will be used to calculate the
  standard_devation.
  
  Parameters:
    win_condition: A string that determines 
    which types of games will be used to calculate
    the score standard deviation.  Must be either
    'W', 'L', or 'ALL' to specify games that were 
    won, lost, or all games.

  Returns: A float value representing OSU's score standard deviation.
=end
  def osu_score_std_dev win_condition
    score_array = osu_score_array win_condition
    Stats.std_dev score_array
  end

=begin
  CREATED: Henry Karagory 02/17/2018

  Description: This method calculates the standard deviation
  for all games played opponents of the current Sport object
  based on the win_condition parameter which specifies
  what types of game will be used to calculate the
  standard_devation.

  Parameters:
    win_condition: A string that determines 
    which types of games will be used to calculate
    the score standard deviation.  Must be either
    'W', 'L', or 'ALL' to specify games that were 
    won, lost, or all games.

  Returns: A float value representing an opponents score standard deviation
=end
  def opponent_score_std_dev win_condition
    # Obtain the mean 
    score_array = opponent_score_array win_condition
    Stats.std_dev score_array
  end

=begin
  CREATED: Henry Karagory 02/17/2018
  MODIFIED: David Levine 02/20/2018
    -Added return information to the specs
    -removed explicit return from method

  Description:  This method returns an array with 
  the scores for all games played by the current Sport
  object based on the win condition parameter which 
  specifies which types of games that will be included in
  the array.

  Parameters:
    win_condition:  A string that determines what
    types of game scores will be included in the 
    returned array.  Must be either 'W', 'L', or 
    'ALL' to specify games that were won, lost or 
    all games

    Returns: an array containing the scores for all OSU games played depending on 
    win_condition
=end
  def osu_score_array win_condition
    score_array = []
    @months.each do |month|
      score_array += month.osu_score_array win_condition
    end
    score_array
  end

=begin
  CREATED: Henry Karagory 02/17/2018
  MODIFIED: David Levine 02/20/2018
    -Added return information to the specs
    -removed explicit return from method

  Description:  This method returns an array with 
  the scores for all games played by the opponents of the 
  current Sport object based on the win condition parameter 
  which specifies which types of games that will be 
  included in the array.

  Parameters:
    win_condition:  A string that determines what
    types of game scores will be included in the 
    returned array.  Must be either 'W', 'L', or 
    'ALL' to specify games that were won, lost or 
    all games
  
  Returns: an array containing the scores for all opponent games played depending on 
    win_condition
=end
  def opponent_score_array win_condition
    score_array = []
    @months.each do |month|
      score_array += month.opponent_score_array win_condition
    end
    score_array
  end
end
