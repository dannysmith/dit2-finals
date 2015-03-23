# Provides access to the Courses
#-------------------------------------------------------------------------------------------------------------
# Author:      Danny Smith (dsmith@testingcircle.com)
# Modified:    2014-01-15
#
# Usage:
#
# @c = Course.new(browser, params)
#           Creates a new Course where `browser` is the browser object,
#
#
# Course.all                   Returns an array of all the Course objects.
# Course.first                 Returns the first Course created
# Course.last                  Returns the last Course created
#
#-------------------------------------------------------------------------------------------------------------


##################### WARNING #####################

## NOTE: This is an example of how to use data object.
## There is no functionality built into it.
## This Does not Work!

##################### WARNING #####################


require 'betterlorem'

class Course
  attr_accessor :course_id, :data

  @@courses = []

  def initialize(browser, params = {})

    @browser = browser




    #---------------------
    # Create a Course using the API and set whatever instance variables are required to describe it
    # Put the code to do this here.
    #---------------------




    # Add to class variable
    @@courses << self

    return self
  end


  # Class methods

  def self.all
    return @@courses
  end

  def self.last
    return @@courses.last
  end

  def self.first
    return @@courses.first
  end
end
