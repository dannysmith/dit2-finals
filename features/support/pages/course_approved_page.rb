class CourseApprovedPage < GenericPage
  def get_course_id
    @browser.url[/\d+/]
  end
end