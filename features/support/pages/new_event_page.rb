class NewEventPage < GenericPage
  def visit
    @browser.goto EnvConfig.new_event_url
  end

  def event_type(type)
    @browser.select_list.select type
  end

  def fill_form(event_name, description)
    self.event_name = event_name
    self.description = description
    self.submit
  end

  def event_name=(name)
    @browser.input(id: 'name').set name
  end

  def description=(description)
    @browser.div(id: 'id_descriptioneditable').set description
  end

  def submit()
    @browser.input(id: 'id_submitbutton').click
  end

  def check_error
    @browser.span(text: "Required").visible?
  end
end