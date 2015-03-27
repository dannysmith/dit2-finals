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

  def course_page
    CoursePage.new @browser
  end

  def course_search_page
    CourseSearchPage.new @browser
  end

  def course_request_page
    CourseRequestPage.new @browser
  end

  def course_pending
    CoursePendingPage.new @browser
  end

  def logout
    @browser.goto EnvConfig.logout_url
    @browser.input(value: 'Continue').click
  end
end
