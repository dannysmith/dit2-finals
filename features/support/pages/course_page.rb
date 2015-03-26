class CoursePage < GenericPage
  def visit
    @browser.goto "http://unix.spartaglobal.com/moodle/course/index.php"
  end

  def search_for(search_term)
    @browser.text_field(id: "navsearchbox").send_keys search_term
    @browser.input(value: "Go").click
  end
end
