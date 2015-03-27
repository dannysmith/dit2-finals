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

  def expect_errors(full_name_error, short_name_error, reason_error)
    raise 'Incorrect error displayed for full name' unless @browser.div(id: 'fitem_id_fullname').span(class: 'error').text == full_name_error
    raise 'Incorrect error displayed for short name' unless @browser.div(id: 'fitem_id_shortname').span(class: 'error').text == short_name_error
    raise 'Incorrect error displayed for reason' unless  @browser.div(id: 'fitem_id_reason').span(class: 'error').text == reason_error 
  end
end