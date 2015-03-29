class CourseRequestPage < GenericPage
  ERROR_MESSAGE = {
    fullname: 'Incorrect error displayed for full name',
    shortname: 'Incorrect error displayed for short name',
    reason: 'Incorrect error displayed for reason'
  }

  ELEMENT = {
    fullname: { id: 'fitem_id_fullname' },
    shortname: { id: 'fitem_id_shortname' },
    reason: { id: 'fitem_id_reason' },
    error: { class: 'error' }
  }

  def visit
    @browser.goto EnvConfig.course_request_url
  end

  def fill_form(course_details = {})
    self.full_name = course_details.fetch(:fullname)
    self.short_name = course_details.fetch(:shortname)
    self.summary = course_details.fetch(:summary)
    self.reason = course_details.fetch(:reason)
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

  def error_displayed(key)
    raise "This element does not exist" unless @browser.div(ELEMENT[key]).span(ELEMENT[:error]).exists?
    @browser.div(ELEMENT[key]).span(ELEMENT[:error]).text
  end

  def expect_errors(error_messages)
    raise ERROR_MESSAGE[:fullname] unless error_displayed(:fullname) == error_messages.fetch(:fullname)
    raise ERROR_MESSAGE[:shortname] unless error_displayed(:shortname) == error_messages.fetch(:shortname)
    raise ERROR_MESSAGE[:reason] unless error_displayed(:reason) == error_messages.fetch(:reason)
  end
end
