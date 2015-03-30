class CoursePendingPage < GenericPage
  ELEMENT = {
    approve: {value: 'Approve'}
  }

  def visit
    @browser.goto EnvConfig.course_pending_url
  end

  def approve
    @browser.input(ELEMENT[:approve]).click
  end
end
