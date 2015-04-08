class NewEventPage < GenericPage
  def visit
    @browser.goto EnvConfig.base_url + EnvConfig.new_event_url
  end

  def visit_with(course_id)
    @browser.goto EnvConfig.base_url + EnvConfig.new_group_event_url + course_id
  end

  def event_type=(type)
    @browser.select_list.select type
  end

  def fill_form(event_name, description)
    self.event_name = event_name
    self.description = description
    submit
  end

  def event_name=(name)
    @browser.input(id: 'id_name').send_keys name
  end

  def description=(description)
    @browser.div(id: 'id_descriptioneditable').send_keys description
  end

  def submit()
    @browser.input(id: 'id_submitbutton').click
  end

  def check_error
    @browser.span(text: "Required").visible?
  end
end
