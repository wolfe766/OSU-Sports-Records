# Project 3
### Web Scraping

### Roles
* Overall Project Manager: Alec Maier
* Coding Manager: Sam Wolfe
* Testing Manager: Brandon Brown
* Documentation: David Levine

### Contributions
Please list who did what for each part of the project.
Also list if people worked together (pair programmed) on a particular section.

* Development
  * Alec: 
  * Sam: Implemented the "Print Table" function, wrote the CSS pertaining to those tables. Wrote game class.
  * Henry:
  * David: Implemented and created the core functionality of month.rb class. Implemented the generate_page, write_doctype_head_and_open_body, generate_tabing_string, sport_name_generator, and write_closing_body methods in the page_generator.rb class. Added CSS rules for the coloring key describing each game/event.
  * Brandon: Implemented the generation of the home_page.html file and and ERB file to create a web page that has links to individual sports webpages that contain parsed data. Implemented test script for the Game class.

* Testing
  * Alec: 
  * Sam: Performed integration testing when combining Print Table into the core of the project as well as testing of CSS. 
  * Henry:
  * David: Wrote test cases for the Month class (intialization and add_game) and test cases for the generate_simple_tag in the Generate_page class. Additionally, I ran the generated HTML for the home page and one sport page through W3's html validator (https://validator.w3.org/) and made appropriate changes to our page generation class and css styling sheet.
  * Brandon: Implemented game_test.rb for unit testing. Checked that all test scripts tested that each method was throughly tested.

* Documentation
  * Alec: 
  * Sam: Wrote documentation for the Print Table function and for any modified methods. 
  * Henry:
  * David: Wrote method specifications for generate_page, write_doctype_head_and_open_body, generate_tabing_string, sport_name_generator, and write_closing_body. Also went through entire teams specs before final meeting and reviewed and updated specifications as needed (for examples, adding returns and updates when needed).
  * Brandon: Wrote documentation for game_test.rb and the generation of the home_page method in page_generation.rb. Checked formatting of test scripts and that all scripts have documentation of UUT.


Instructions for Execution:

Type 'ruby scraper_main.ruby' into the console to execute the program. This results in the parsing of the data from www.ohiostatebuckeyes.com website and generates corresponding html files from the parsed data. After the html files are generated a firefox window will open. The firefox window will open displaying the main page to navigate between different sports schedule and statistics. The HTML produced can be found in the output folder.

 
Testing Plan: 

All core functionality has been tested. Unit testing involved all team members utilizing Minitest to perform testing on their implementation and other team member's implementation. Integration testing was done manually by checking the html files in a browser that were generated.

Additionally, the HTML outputted by the program was ran through W3's html validator (https://validator.w3.org/) to ensure the documents were appropriately generated.
