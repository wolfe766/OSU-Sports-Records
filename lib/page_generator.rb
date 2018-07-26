=begin
  CREATED: Sam Wolfe 2/16/2018
  MODIFIED: David Levine 2/16/2018
    -Added gen_tag method
  MODIFIED: Brandon Brown 02/17/2018
    -added gen_home_page
  MODIFIED: Henry Karagory 02/18/2018
    -added gen_statistics_table method
  MODIFIED: David Levine 02/20/2018
    -Updated specs
  Description: This class handles the generation of all HTML elements,
  ensuring proper formatting as well.
=end

require_relative './month.rb'
require 'erb'
require_relative './sport.rb'
require 'io/console'

class Page_Generator 
 
=begin
  CREATED: David Levine 2/17/2018
  
  Definition: initializes a new Page_Generator with a 
  ./files/ as the default directory unless otherwise specified.
    
  Parameters:
    -directory: the directory of where the main files should be.
=end
  def initialize (directory = "output/")
    @page_print_directory = directory
  end

  attr_accessor :page_print_directory

=begin
  CREATED: David Levine 2/16/2018

  DESCRIPTION: The following method will gen an entire tag based of the tag,
               content, and attribute_strings passed in.
               For example, given a tag "h1", content of "title", and attribute string
               of 'style=\"background-color:Tomato;\"' we will get the tag:
               <h1 style="background-color:Tomato;">title</h1>it

  Parameters:
    -tag: a string containing a valid tag ('h1' is a valid example)
    -content: a string containing the content the tag should display
    -attribute_strings: a collection of strings which are valid ('style=\"background-color:Tomato;\"'  is a valid example)

  Returns: A valid html tag.
=end
  def gen_simple_tag tag, content, *attribute_strings
    gend_tag = "<" + tag
    unless attribute_strings.length == 0
      gend_tag += " "
      #use reduce to combine all attributes into a single string 
      gend_tag += attribute_strings.reduce do |combined_attr, current_attr|
        combined_attr += " " + current_attr 
      end
    end
    gend_tag += ">" + content + "</" + tag + ">"
  end

=begin 
  CREATED: Brandon Brown 2/17/18
  MODIFIED: David Levine 02/20/2018
    -Added parameters and Returns to the specs.

  Description: gen home page and links to other html files
  
  Parameters:
    -sports: an array containing strings of all sports names.
    -months: an array containing strings of all months.

  Returns:
    -an html page named home_page.html written to the file described in the directory.
=end
  def gen_home_page sports, months

    # Render template
    erb_file = './files/home_page.html.erb'
    html_file = @page_print_directory + File.basename(erb_file, '.erb')

    erb_str = File.read(erb_file)

    sports = sports.map{|sport_name| Sport.new sport_name, months}
    sports_link = sports.map{|sport| sport_name_generator sport}

    render = ERB.new(erb_str)
    result = render.result(binding)

    File.open(html_file, 'w') do |f|
      f.write(result)
    end
  end

=begin
  CREATED: Sam Wolfe 2/17/2018
  MODIFIED: David Levine 2/17/2018
    -Replaced hardcoded tabbings with offest tabbings based on an inital tab offset

  Description: This function takes a month object and gens a properly formatted HTML table
  with correct CSS tags.

  Parameters:
    -month: A month object containing game objects for that month
    -tabs: how many tabs the first html element should start with.

  
  Returns: an html string that shows a table with with the appropriate table data.
=end
  def gen_table month, tabs
    cur_year = month.game_objects[0].date.year
    table_html = (gen_tabs tabs) + "<div class=\"table_title\">\n"
    tabs += 1
    table_html += (gen_tabs tabs) + "<span class=\"month_title\">" + month.name +
        " " + cur_year.to_s + "</span>\n"
    table_html += (gen_tabs tabs) + "<span class=\"month_record\">Record: " +
        month.wins.to_s + "-" + month.losses.to_s + "-" + month.ties.to_s + "</span>\n"
    tabs -= 1
    table_html += (gen_tabs tabs) + "</div>\n"

    table_html += (gen_tabs tabs) + "<table class=\"month_table\">\n"
    tabs += 1
    table_html += (gen_tabs tabs) + "<tr class=\"table_header\">\n"
    tabs += 1
    table_html += (gen_tabs tabs) + "<th>Day</th>\n"
    table_html += (gen_tabs tabs) + "<th>W/L</th>\n"
    table_html += (gen_tabs tabs) + "<th>Opponent/Event</th>\n"
    table_html += (gen_tabs tabs) + "<th>Score OSU</th>\n"
    table_html += (gen_tabs tabs) + "<th>Score Opp</th>\n"
    table_html += (gen_tabs tabs) + "<th>Time</th>\n"
    table_html += (gen_tabs tabs) + "<th>Location</th>\n"
    tabs -= 1
    table_html += (gen_tabs tabs) + "</tr>\n"

    month.game_objects.each do |game|
      tabs += 1
      if game.date == Date::today
        table_html += (gen_tabs tabs) + "<tr class=\"month_table_row today\">\n"
      elsif game.completed? == -1
        table_html += (gen_tabs tabs) + "<tr class=\"month_table_row incomplete\">\n"
      elsif game.completed? == 1 && game.game_result == ""
        table_html += (gen_tabs tabs) + "<tr class=\"month_table_row no_data\">\n"
      elsif game.game_result == "W"
        table_html += (gen_tabs tabs) + "<tr class=\"month_table_row win\">\n"
      elsif game.game_result == "L"
        table_html += (gen_tabs tabs) + "<tr class=\"month_table_row loss\">\n"
      else
        table_html += (gen_tabs tabs) + "<tr class=\"month_table_row tie\">\n"
      end

        tabs += 1
        result = (game.completed? == 1) ? game.game_result.to_s : ' '
        table_html += (gen_tabs tabs) + "<td>" + game.date.mday.to_s + "</td>\n"
        table_html += (gen_tabs tabs) + "<td>" + result + "</td>\n"
        table_html += (gen_tabs tabs) + "<td>" + game.opponent.to_s + "</td>\n"
        tabs -= 1
      
      
      if game.completed? == 1
        table_html += (gen_tabs tabs) + "<td>" + game.score_osu.to_s + "</td>\n"
        table_html += (gen_tabs tabs) + "<td>" + game.score_opponent.to_s + "</td>\n"
        table_html += (gen_tabs tabs) + "<td></td>\n"
      else
        table_html += (gen_tabs tabs) + "<td></td>\n"
        table_html += (gen_tabs tabs) + "<td></td>\n"
        table_html += (gen_tabs tabs) + "<td>" + game.time.to_s + "</td>\n"
      end

        table_html += (gen_tabs tabs) + "<td>" + game.location + "</td>\n"
        tabs -= 1
        table_html += (gen_tabs tabs) + "</tr>\n"
    
        
    end 
    table_html += (gen_tabs tabs) + "</table>\n"
  end

=begin
  CREATED: David Levine 2/17/2018

  Description: will gen a page for a particular sport, and will write a table for each of the
  games each month.

  Parameters:
    -sport: a sport object populated with month objects that should be written to the flies folder.

  Returns:
    -an html page named (sport.name).html written to the file described in the directory.
=end
  def gen_page sport
    #get the html file name we want
    file_name = sport_name_generator sport
    #open page up
    file_name = @page_print_directory + file_name
    sport_file = File.new file_name, "w"
    #write the head and the opening body tag, and get the number of tabs returned
    tabs = write_doctype_head_and_open_body sport_file, sport.name
    
    sport_file.write (gen_tabs tabs) +
                                "<link rel=\"stylesheet\" type=\"text/css\" href=\"..\\files\\style.css\" />\n"

    sport_file.write (gen_tabs tabs) + "<div class=\"opening_information\">\n"
    tabs += 1
    sport_file.write (gen_tabs tabs) +
                                (gen_simple_tag "h1", (sport.name + " Games and Stats")) + "\n"
    tabs += 1
    sport_file.write (gen_tabs tabs) + "<div class=\"bordering\">\n"
    tabs += 1
    sport_file.write (gen_tabs tabs) +
                                (gen_simple_tag "h1", "Table Coloring Key") + "\n"
    
    sport_file.write (gen_tabs tabs) +
                                (gen_simple_tag "p", "Winning games are green!",
                                                     "class=win") + "\n"
    sport_file.write (gen_tabs tabs) +
                                (gen_simple_tag "p", "Losing games are red!",
                                                     "class=loss") + "\n"
    sport_file.write (gen_tabs tabs) +
                                (gen_simple_tag "p", "Games/events yet to be played are grey!",
                                                     "class=incomplete") + "\n"
    sport_file.write (gen_tabs tabs) +
                                (gen_simple_tag "p", "Games ending in a tie are yellow!",
                                                     "class=tie") + "\n"
    sport_file.write (gen_tabs tabs) +
                                (gen_simple_tag "p", "Games happening today are blue!",
                                                     "class=today") + "\n"
    sport_file.write (gen_tabs tabs) +
                                (gen_simple_tag "p", "Cancelled Game/No Data Available",
                                                     "class=no_data") + "\n"
    sport_file.write (gen_tabs tabs) + "<a id=\"link_to_homepage\" href=\"home_page.html\">\n"  
    tabs += 1
    sport_file.write (gen_tabs tabs) + "Go Home!\n"  
    tabs -= 1
    sport_file.write (gen_tabs tabs) + "</a>\n"  
    
    tabs -= 1
    sport_file.write (gen_tabs tabs) + "</div>\n"
    tabs -= 1
    sport_file.write (gen_tabs tabs) + "</div>\n"
   

    #Display stats for sport
    sport_file.write (gen_tabs tabs) + (gen_simple_tag "h3", "Stats for " +
        sport.name, "class=\"stats_title\"") + "\n"
    sport_file.write (gen_statistics_table tabs, sport)
    
    #begin looping through and writing tables
    sport.months.each do |month|

      unless month.game_objects.length == 0
        sport_file.write (gen_tabs tabs) + "<div>\n"
        tabs += 1
        sport_file.write ((gen_table(month, tabs)) + "\n")
        
        sport_file.write (gen_tabs tabs) + "<br />\n"
        tabs -= 1
        sport_file.write (gen_tabs tabs) + "</div>\n\n"
      end
    end

    #Add body and html closing tags, and then close the file writer.
    write_closing_body sport_file
    sport_file.close
  end

=begin
  CREATED: David Levine 2/17/2018

  Description: will gen a page for a particular sport, and will write a table for each of the
  games each month.

  Parameters:
    -file_stream: An open IO string to the file you want to write to.
    -page_title: The name of the page you want to put in html document.

  Updates:
    -file_stream file with a header and body

   returns:
    -integer representing the amount of tabs of the last printed object
=end
  def write_doctype_head_and_open_body file_stream, page_title
    tabs = 0                
    
    file_stream.write "<!DOCTYPE html>\n"
    file_stream.write "<html>\n"
    tabs += 1
    file_stream.write (gen_tabs tabs) + "<head>\n"
    tabs += 1
    file_stream.write (gen_tabs tabs) + (gen_simple_tag "title", page_title) + "\n"
    file_stream.write (gen_tabs tabs) + "<meta charset=\"utf-8\" />\n" 
    tabs -= 1
    file_stream.write (gen_tabs tabs) + "</head>\n"
    file_stream.write (gen_tabs tabs) + "<body>\n"
    tabs
  end



=begin
  CREATED: David Levine 2/17/2018

  Description: will gen a page for a particular sport, and will write a table for each of the
  games each month.

  Parameters:
    -file_stream: An open IO string to the file you want to write to.

  Updates:
    -file_stream file with a header and body
=end
  def write_closing_body file_stream
                  
      file_stream.write "\t</body>\n"
      file_stream.write "</html>"
   
  end

=begin
  CREATED: David Levine 2/17/2018
  
  Description: makes a string containing \t contactenated together based on the 
  variable number of tabs

  Parameters:
    -an integer representing the number of tabs to print

  Updates:
    -returns a string with number_of_tabs \t contactented together.
=end
  def gen_tabs number_of_tabs
      tabs = ""
      number_of_tabs.times {tabs += "\t"}
      tabs
  end
 

=begin
  CREATED: Henry Karagory 02/18/2018
  MODIFIED: David Levine 02/20/2018
    -Updated specs with parameters and return information

  Description:  This function gens a properly
  formatted HTML table that contains statistical information
  about the @sport object.

  Parameters:
    -tabs: how many tabs the first html element should start with.
    -sport: the sport object you would like to do statistical calculations on.

  Returns: A string containing HTML representing a stats table for a particular sport.
    
=end
  def gen_statistics_table tabs, sport
    stat_table = (gen_tabs tabs) + "<table id='stat_table'>\n"
    tabs += 1
    # gen the table header.
    stat_table += (gen_tabs tabs) + "<tr class=\"table_title\">\n"
    tabs += 1
    stat_table += (gen_tabs tabs) + "<th>Average Score All Games</th>\n"
    stat_table += (gen_tabs tabs) + "<th>Score Standard Deviation</th>\n"
    stat_table += (gen_tabs tabs) + "<th>Average Win Margin</th>\n"
    stat_table += (gen_tabs tabs) + "<th>Average Loss Margin</th>\n"
    stat_table += (gen_tabs tabs) + "<th>Average Opponent Score</th>\n"
    stat_table += (gen_tabs tabs) + "<th>Opponent Score Standard Deviation</th>\n"
    tabs -= 1
    stat_table += (gen_tabs tabs) + "</tr>\n"

    # gen the statistics and table content.
    stat_table += (gen_tabs tabs) + "\t<tr>\n"
    tabs += 1
    stat_table += (gen_tabs tabs) + "<td>" + sport.osu_avg_score('ALL').round(2).to_s + "</td>\n"
    stat_table += (gen_tabs tabs) + "<td>" + sport.osu_score_std_dev('ALL').round(2).to_s + "</td>\n"
    stat_table += (gen_tabs tabs) + "<td>" + sport.osu_avg_score_margin('W').round(2).to_s + "</td>\n"
    stat_table += (gen_tabs tabs) + "<td>" + sport.osu_avg_score_margin('L').round(2).to_s + "</td>\n"
    stat_table += (gen_tabs tabs) + "<td>" + sport.opponent_avg_score('ALL').round(2).to_s + "</td>\n"
    stat_table += (gen_tabs tabs) + "<td>" + sport.opponent_score_std_dev('ALL').round(2).to_s + "</td>\n"
    tabs -= 1
    stat_table += (gen_tabs tabs) + "</tr>\n"

    stat_table += (gen_tabs tabs) + "</table>\n"

  end

=begin
  CREATED: David Levine 2/18/2018

  Description: Method takes in a sport object and returns the name of the object
  as a valid html filename
  
  requires: valid sport object
  
  returns: the name of the sport name with spaces and appostophies removed and html removed.
=end
  def sport_name_generator sport
    (sport.name.gsub /' /, "") + ".html"
  end
end
