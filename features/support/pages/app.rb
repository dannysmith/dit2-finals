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

  def signup
    SignUpPage.new @browser
  end

  def tp_email
    ThirdPartyEmail.new @browser
  end

  def new_event
    NewEventPage.new @browser
  end

  def calendar
    CalendarPage.new @browser
  end

  def calendar_day
    CalendarDayPage.new @browser

  def course_enrol
    CourseEnrolPage.new @browser
  end

  def course_approved
    CourseApprovedPage.new @browser
  end

  def logout
    @browser.goto EnvConfig.logout_url
    @browser.input(value: 'Continue').click
  end
end
