=begin
  CREATED: Henry Karagory and Alec Maier 02/16/2018
  MODIFIED: David Levine 02/20/2018
    -updated the specs with updates and return information

  This is a module that acts as a namespace for several parser functions that
  assist the web scraper.
=end

require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'date'
require_relative './game.rb'
require_relative './sport.rb'

module Parser

=begin
  CREATED: Alec Maier 02/18/2018
  MODIFIED: David Levine 02/20/2018
    -Added return information to specs and revised description

  Description: Parses a link containing month and year information
  and creates a date object for the day of a game.

  Parameters:
    day_number: the day of the current game
    link: the text link for the corresponding calendar month page

  Returns: 
    A date object containing a day based on the day, month, and year 
    provided in day_number and year.
=end
  def Parser.create_game_date(day_number, link)
    mo_and_yr = link.text.split(' ')
    game_date = Date.new mo_and_yr[1].to_i, Date::MONTHNAMES.index(mo_and_yr[0]), day_number
  end

=begin
  CREATED: Alec Maier 02/18/2018

  Description: Parses all the relevant data for a game object, puts it in
    the game object, and populates the appropriate sport object with the game object.

  Parameters:
    game: A string of HTML containing the data for a game
    game_date: A Date object containing the date of the current game
    sport_objects_hash: A hash with the names of sports as the keys and their
      sport objects as the value.

  Updates: 
    sport_objects_hash: each sport in the sport_objects_hash will be updated so
    that it contains all the appropriate game data for each month
=end
  def Parser.parse_game_info(game, game_date, sport_objects_hash)

    # Get data as strings
    event_information = game.text.split("\n")
    sport_name = event_information[1].gsub /\t/, ''
    opponent = event_information[2].gsub /\t/, ''
    result = event_information[3].gsub /\t/, ''
    location = event_information[4].gsub /\t/, ''

    # Obtain the Sport object corresponding to the current game.
    current_sport_object = sport_objects_hash[sport_name]

    # check if the sport is a sport we are considering
    if current_sport_object != nil
      #Create game object
      current_game = Game.new game_date, location, opponent
      # check if game is in the future - we are disregarding today's games
      if game_date > Date.today
        current_game.time = result;
      end
      #check if game has valid win/loss result, which also indicates that it has been played
      if /^[WLT], /.match(result) != nil
        # parse the game result
        game_result = result.split(',')
        current_game.game_result = game_result[0]
        game_scores = game_result[1].split(/[-(]/)
        # assign scores based on result
        if current_game.game_result == 'W'
          current_game.score_osu = game_scores[0]
          current_game.score_opponent = game_scores[1]
        else
          current_game.score_osu = game_scores[1]
          current_game.score_opponent = game_scores[0]
        end
      end
      # add the game to the appropriate sport
      current_sport_object.add_game current_game
    end
  end

=begin
  CREATED: Alec Maier 02/18/2018
  MODIFIED: David Levine 02/20/2018
    -Added Updates to the specs.

  Description: Parses the game data from the calendar page for each month

  Parameters:
    agent: The Mechanize object
    month_links: HTML containing the links to all month calendar pages
    sport_objects_hash: A hash with the names of sports as the keys and their
      sport objects as the value.

  Updates: 
    sport_objects_hash: each sport in the sport_objects_hash will be updated so
    that it contains all the appropriate game data for each month
=end
  def Parser.parse_calendar(agent, month_links, sport_objects_hash)
    month_links.each do |link|

      # Get the url of the page and use mechanize to obtain it using a GET request.
      month_page_url = link['href']
      month_page = agent.get(month_page_url)

      # Obtain all of the rows on the calendar
      calendar_rows = month_page.css('#full-calendar tr')

      # Loop through each row on the calendar.
      calendar_rows.each do |row|

        #  Obtain all of the td elements in a row on the calendar.
        #  The td elements correspond to days.
        row_days = row.css("td")

        #  Loop through each day.
        row_days.each do |day|

          # Obtain the day number and all the games that occurred on one day.
          day_number = day.css(".daynumber").text.to_i
          games = day.css(".calcontent")

          #  Loop through each game
          games.each do |game|
            # create a date object for the game based on the calendar page it's in
            game_date = create_game_date(day_number, link)

            # Obtain all the relevant data about past and future games
            parse_game_info(game, game_date, sport_objects_hash)
          end
        end
      end
    end
    puts "Data scraped! Opening page in Firefox..."
  end

end
