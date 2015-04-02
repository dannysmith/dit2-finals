class CourseDetailsPage < GenericPage
  def select_group
    @browser.span(text: "Users").click
    @browser.a(text: "Groups").click
  end

  def select_new_event
    @browser.a(text: "New event").click
  end
end