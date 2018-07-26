=begin
  CREATED: Alec Maier 02/18/2018

  Main code for the web scraper. This file creates a Mechanize agent for the main
  OSU calendar page and then, using nokogiri, accesses the links for all month calendar
  pages. The code then calls the parser class to parse the sport data from these pages.
=end

require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'date'
require_relative 'lib/game.rb'
require_relative 'lib/sport.rb'
require_relative 'lib/parser.rb'
require_relative 'lib/page_generator.rb'


# sports array holds the name of the sports that the program create HTML pages for
SPORTS = ['Men\'s Soccer', 'Women\'s Soccer', 'Men\'s Volleyball', 'Women\'s Volleyball', 'Football',
          'Men\'s Gymnastics', 'Women\'s Gymnastics', 'Men\'s Basketball', 'Women\'s Basketball',
          'Baseball', 'Softball', 'Synchronized Swimming', 'Women\'s Ice Hockey', 'Men\'s Ice Hockey',
          'Men\'s Tennis', 'Women\'s Tennis', 'Wrestling', 'Men\'s Lacrosse', 'Women\'s Lacrosse',
          'Field Hockey']

Dir.mkdir("output") unless File.exists?("output")

# Declare a mechanize agent and get the page that contains the calendar to
# be scraped.
agent = Mechanize.new
calendar_page = agent.get('http://www.ohiostatebuckeyes.com/calendar/events/')

# Get the links to the pages that hold all previous and future calendars.
month_links = calendar_page.css('div#main-content table b a')

# Parse month links for months sorted in chronological order
months_array = []
month_links.each {|link| months_array << link.text.split[0]}

# Create a hash associating team names with sport objects
sport_objects_hash = Hash.new
SPORTS.each do |sport_name|
  sport_objects_hash[sport_name] = Sport.new sport_name, months_array
end

# Scrape the page's HTML for sport data.
puts "Scraping sport data..."
Parser.parse_calendar(agent, month_links, sport_objects_hash)

#gen HTML pages to display the data in an interesting way.
page_generator = Page_Generator.new

page_generator.gen_home_page SPORTS, months_array
sport_objects_hash.each_value do |sport_object|
  page_generator.gen_page sport_object
end

#pull up the main page for the user
exec("firefox -new-window ./output/home_page.html")
