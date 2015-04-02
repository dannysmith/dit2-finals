class CourseApprovedPage < GenericPage
  def visit(id)
    @browser.goto 'http://unix.spartaglobal.com/moodle/couse/edit.php?id=' + id
  end

  def get_course_id
    @browser.url[/\d+/]
  end
end