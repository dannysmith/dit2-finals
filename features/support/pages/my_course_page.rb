class MyCoursePage < GenericPage
  def visit
    @browser.goto "http://unix.spartaglobal.com/moodle/my/"
  end

  def select_course(fullname)
    @browser.a(title: fullname).click
  end
end