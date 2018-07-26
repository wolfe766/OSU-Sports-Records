=begin
  CREATED: Henry Karagory 02/17/2018
  MODIFIED: David Levine 02/20/2018
    -Added return information to specs

	This file contains the Stats module which
	is used as a namespace for several
	statistical and array helper functions.
=end

module Stats

=begin
  CREATED: Henry Karagory 02/17/2018
  MODIFIED: David Levine 02/18/2018
    -added return information

  Description:  This function calculates the sample
  standard deviation of the values in the parameter array.

  Parameters:  
  	array:  An object of class array that contains the 
  	values that will be used to calculate the standard
  	deviation.  The parameter array must have length
  	greater than one.
	
  Returns: float value representing the standard deviation of the array.
=end
  def Stats.std_dev array
  	return 0 if array.length <=1
    mean = average array
    mse = array.reduce(0){|acc, item| acc += (item - mean)**2}
    Math.sqrt(mse/(array.length-1.0)) 
  end

=begin
  CREATED: Henry Karagory 02/17/2018
  MODIFIED: David Levine 02/18/2018
    -added return information

  Description:  This function calculates the
	average of the values in the parameter array.

  Parameters:  
  	array:  An object of class array that contains the 
  	values that will be used to calculate the average.  
  
  Returns: a float value representing the average value of all numbers
           in the given array.
=end
  def Stats.average array
    return 0 if array == []
    Stats.sum(array)/array.length.to_f
  end

=begin
  CREATED: Henry Karagory 02/17/2018
  MODIFIED: David Levine 02/18/2018
    -added return information

  Description:  This function calculates the
	sum of the values in the parameter array.

  Parameters:  
  	array:  An object of class array that contains the 
  	values that will be used to calculate the sum.  
  
  Returns: a value representing the sum of all the values in the array.
=end
  def Stats.sum array
    return 0 if array == []
    array.reduce {|acc, term| acc += term}
  end
end
