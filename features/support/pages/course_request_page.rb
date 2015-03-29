class CourseRequestPage < GenericPage
  def visit
    @browser.goto EnvConfig.course_request_url
  end

  def fill_form(course_details = {})
    full_name = course_details.fetch(:fullname)
    short_name = course_details.fetch(:shortname)
    summary = course_details.fetch(:summary)
    reason = course_details.fetch(:reason)
    self.full_name= full_name
    self.short_name= short_name
    self.summary= summary
    self.reason= reason
    self.submit
  end

  def full_name=(full_name)
    @browser.text_field(id: 'id_fullname').set full_name
  end

  def short_name=(short_name)
    @browser.text_field(id: 'id_shortname').set short_name
  end

  def summary=(summary)
    @browser.element(id: 'id_summary_editoreditable').send_keys summary
  end

  def reason=(reason)
    @browser.textarea(id: 'id_reason').set reason
  end

  def submit
    @browser.button(id: 'id_submitbutton').click
  end

  def expect_errors(error_messages)
    raise 'Incorrect error displayed for full name' unless @browser.div(id: 'fitem_id_fullname').span(class: 'error').text == error_messages.fetch(:fullname)
    raise 'Incorrect error displayed for short name' unless @browser.div(id: 'fitem_id_shortname').span(class: 'error').text == error_messages.fetch(:shortname)
    raise 'Incorrect error displayed for reason' unless  @browser.div(id: 'fitem_id_reason').span(class: 'error').text == error_messages.fetch(:reason) 
  end
end
