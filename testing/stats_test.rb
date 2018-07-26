=begin
  CREATED: Henry Karagory 2/19/2018

  The following file contains test cases for the Stats module.
=end

require "minitest/autorun"
require_relative "../lib/stats.rb"

class TestStats < Minitest::Test
  
  def setup
    @array1 = [1, 2, 3, 4]
    @array2 = [7, 6, 8, 11]
  end

=begin
  CREATED: Henry Karagory 2/19/2018

  Description: Tests the sum of the first array.
=end  
  def test_sum_array_1
    expected_sum = 10
    assert_equal expected_sum, Stats.sum(@array1)
  end

=begin
  CREATED: Henry Karagory 2/19/2018

  Description: Tests the sum of the second array.
=end  
  def test_sum_array_2
    expected_sum = 32
    assert_equal expected_sum, Stats.sum(@array2)
  end

=begin
  CREATED: Henry Karagory 2/19/2018

  Description: Tests the sum of an empty array.
=end  
  def test_sum_empty_array
    expected_sum = 0
    assert_equal expected_sum, Stats.sum(Array.new)
  end

=begin
  CREATED: Henry Karagory 2/19/2018

  Description: Tests the mean of the first array.
=end  
  def test_mean_array_1
    expected_mean = 2.5
    assert_equal expected_mean, Stats.average(@array1)
  end

=begin
  CREATED: Henry Karagory 2/19/2018

  Description: Tests the mean of the second array.
=end  
  def test_mean_array_2
    expected_mean = 8
    assert_equal expected_mean, Stats.average(@array2)
  end

=begin
  CREATED: Henry Karagory 2/19/2018

  Description: Tests the mean of an empty array.
=end  
  def test_mean_empty_array
    expected_sum = 0
    assert_equal expected_sum, Stats.average(Array.new)
  end

=begin
  CREATED: Henry Karagory 2/19/2018

  Description: Tests the standard deviation of the first array.
=end  
  def test_std_dev_array_1
    expected_std_dev = 1.2909
    assert_in_delta expected_std_dev, Stats.std_dev(@array1), 0.01
  end

=begin
  CREATED: Henry Karagory 2/19/2018

  Description: Tests the standard deviation of the second array.
=end  
  def test_std_dev_array_2
    expected_std_dev = 2.16024
    assert_in_delta expected_std_dev, Stats.std_dev(@array2), 0.01
  end

=begin
  CREATED: Henry Karagory 2/19/2018

  Description: Tests the standard deviation of an empty array.
=end  
  def test_std_dev_empty_array
    expected_sum = 0
    assert_equal expected_sum, Stats.std_dev(Array.new)
  end
end
