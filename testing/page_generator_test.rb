=begin
  CREATED: David Levine 2/16/2018

  DESCRIPTION: Contains test cases for some of the instance methods in the
  Page_generator class
=end

require "minitest/autorun"
require_relative '../lib/page_generator.rb'
require_relative '../lib/sport.rb'

class TestPageGenerator < Minitest::Test
  def setup
    @page_generator = Page_Generator.new
  end

=begin
  CREATED: David Levine 2/16/2018

  Description: Simple tag with no attributes
=end
  def test_tag_no_attributes_1
      expected_tag = "<h1>Hello World!</h1>"

      tag = "h1"
      content = "Hello World!"
      actual_tag = @page_generator.generate_simple_tag tag, content

      assert_equal expected_tag, actual_tag
  end

=begin
  CREATED: David Levine 2/16/2018

  Description: Simple tag with no attributes
=end
  def test_tag_no_attributes_2
      expected_tag = "<th>W/L</th>"

      tag = "th"
      content = "W/L"
      actual_tag = @page_generator.generate_simple_tag tag, content

      assert_equal expected_tag, actual_tag
  end

=begin
  CREATED: David Levine 2/16/2018

  Description: Simple tag with no attributes
=end
  def test_tag_no_attributes_3
      expected_tag = "<td>game won</td>"

      tag = "td"
      content = "game won"
      actual_tag = @page_generator.generate_simple_tag tag, content

      assert_equal expected_tag, actual_tag
  end

=begin
  CREATED: David Levine 2/16/2018
  Description: Simple tag with one attribute
=end
  def test_tag_1_attributes_1
      expected_tag = "<h1 style=\"background-color:DodgerBlue;\">Hello World</h1>"

      tag = "h1"
      content = "Hello World"
      atrribute1 = "style=\"background-color:DodgerBlue;\""
      actual_tag = @page_generator.generate_simple_tag tag, content, atrribute1

      assert_equal expected_tag, actual_tag
  end

=begin
  CREATED: David Levine 2/16/2018
  Description: Simple tag with one attribute
=end
  def test_tag_1_attributes_2
      expected_tag = "<p style=\"background-color:Tomato;\">Lorem ipsum...</p>"

      tag = "p"
      content = "Lorem ipsum..."
      atrribute1 = "style=\"background-color:Tomato;\""
      actual_tag = @page_generator.generate_simple_tag tag, content, atrribute1

      assert_equal expected_tag, actual_tag
  end

=begin 
  CREATED: David Levine 2/16/2018
  Description: Simple tag with two attributes
=end
  def test_tag_2_attributes_1
      expected_tag = "<a href=\"https:\\\\www.google.com\" target=\"_blank\">Google</a>"

      tag = "a"
      content = "Google"
      atrribute1 = "href=\"https:\\\\www.google.com\""
      attribute2 = "target=\"_blank\""
      actual_tag = @page_generator.generate_simple_tag tag, content, atrribute1, attribute2

      assert_equal expected_tag, actual_tag
  end

=begin
  CREATED: David Levine 2/17/2018

  Description: Return an empty string
=end
  def test_generate_tabbing_string_0
    number_of_tabs = 0
    expected_string = ""

    actual_string = @page_generator.generate_tabing_string number_of_tabs
    assert_equal expected_string, actual_string
  end

=begin
  CREATED: David Levine 2/17/2018

  Description: Return on \t
=end
  def test_generate_tabbing_string_1
    number_of_tabs = 1
    expected_string = "\t"

    actual_string = @page_generator.generate_tabing_string number_of_tabs
    assert_equal expected_string, actual_string
  end

=begin
  CREATED: David Levine 2/17/2018

  Description: Return on \t\t
=end
  def test_generate_tabbing_string_2
    number_of_tabs = 2
    expected_string = "\t\t"

    actual_string = @page_generator.generate_tabing_string number_of_tabs
    assert_equal expected_string, actual_string
  end

=begin
  CREATED: David Levine 2/17/2018

  Description: Return on \t\t\t
=end
  def test_generate_tabbing_string_3
    number_of_tabs = 3
    expected_string = "\t\t\t"

    actual_string = @page_generator.generate_tabing_string number_of_tabs
    assert_equal expected_string, actual_string
  end

end
