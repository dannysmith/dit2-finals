class CalendarPage < GenericPage
  def visit
    @browser.goto EnvConfig.calendar_url
  end

  def find_event(event_name)
    @browser.a(text: event_name).click
  end
end