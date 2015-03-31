class CalendarDayPage < GenericPage
  def check_details(event_name, description)
    self.check_description = description
    self.check_event_name = event_name
  end

  def check_description=(description)
    @browser.td(text: description).visible?
  end

  def check_event_name=(event_name)
    @browser.div(text: event_name).visible?
  end
end