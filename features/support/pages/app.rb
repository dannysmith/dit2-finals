# Used for initializing all page objects
#-------------------------------------------------------------------------------------------------------------
# Author:      Aaron Muir
# Modified:    2014-12-11
#-------------------------------------------------------------------------------------------------------------
class App
  def initialize(b)
    @browser = b
  end

  def home
    HomePage.new @browser
  end
end
