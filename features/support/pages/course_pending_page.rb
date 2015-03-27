class CoursePendingPage < GenericPage
  def visit
    @browser.goto EnvConfig.course_pending_url
  end

  def approve
    @browser.input(value: 'Approve').click
  end
end
