class NewEventPage < GenericPage
  def visit
    @browser.goto EnvConfig.new_event_url
  end

  def event_type(type)
    @browser.select_list.select type
  end

  def fill_form(correct_details = {})
    self.event_name = correct_details.fetch(:event_name)
    self.description = correct_details.fetch(:description)
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
end