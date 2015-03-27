class CoursePendingPage < GenericPage
  def visit
    @browser.goto "http://unix.spartaglobal.com/moodle/course/pending.php"
  end

  def approve
    @browser.input(value: 'Approve').click
  end
end
