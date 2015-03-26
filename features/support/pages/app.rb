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

  def login
    LoginPage.new @browser
  end

  def logout
    @browser.goto 'http://unix.spartaglobal.com/moodle/login/logout.php'
    @browser.input(value: 'Continue')
  end
end
