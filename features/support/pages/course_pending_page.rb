class CoursePendingPage < GenericPage
  ELEMENT = {
    approve: { value: 'Approve' }
  }

  def visit
    @browser.goto EnvConfig.course_pending_url
  end

  def approve(course_name)
    @browser.tbody.trs.each do |row|
      if row.tds[1].text == course_name
        row.input(ELEMENT[:approve]).click
        break
      end
    end
  end
end
