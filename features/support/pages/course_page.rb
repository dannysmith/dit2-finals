class CoursePage < GenericPage
  ELEMENT = {
    nav_search: {id: "navsearchbox"},
    submit: {value: "Go"},
    request_course: {value: 'Request a course'}
  }

  def visit
    @browser.goto EnvConfig.course_page_url
  end

  def search_for(search_term)
    @browser.text_field(ELEMENT[:nav_search]).send_keys search_term
    @browser.input(ELEMENT[:submit]).click
  end

  def request_course
    @browser.button(ELEMENT[:request_course]).click
  end
end
