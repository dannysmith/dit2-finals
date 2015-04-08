class MyCoursePage < GenericPage
  def visit
    @browser.goto EnvConfig.base_url + EnvConfig.my_course_url
  end

  def get_course_id(fullname)
    url = @browser.a(title: fullname).attribute_value("href")
    return url[/\d+/]
  end
end