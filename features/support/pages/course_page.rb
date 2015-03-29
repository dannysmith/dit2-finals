class CoursePage < GenericPage
  def visit
    @browser.goto EnvConfig.course_page_url
  end

  def search_for(search_term)
    @browser.text_field(id: "navsearchbox").send_keys search_term
    @browser.input(value: "Go").click
  end

  def request_course
    @browser.button(value: 'Request a course').click
  end
end
