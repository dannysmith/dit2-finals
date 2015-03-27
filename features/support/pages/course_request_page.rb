class CourseRequestPage < GenericPage
  def visit
    @browser.goto 'http://unix.spartaglobal.com/moodle/course/request.php'
  end

  def fill_form(full_name, short_name, summary, reason)
    self.full_name= full_name
    self.short_name= short_name
    self.summary= summary
    self.reason= reason
    self.submit
  end

  def full_name= (full_name)
    @browser.text_field(id: 'id_fullname').set full_name
  end

  def short_name= (short_name)
    @browser.text_field(id: 'id_shortname').set short_name
  end

  def summary= (summary)
    @browser.element(id: 'id_summary_editoreditable').send_keys summary
  end

  def reason= (reason)
    @browser.text_field(id: 'id_reason').set reason
  end

  def submit
    @browser.button(id: 'id_submitbutton').click
  end
end
