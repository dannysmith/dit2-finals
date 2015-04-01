EVENT_DETAILS = {
  event_name: 'Test Event',
  description: 'This is a test event'
}

Given(/^I am logged in as (admin|user)$/) do |account|
  @app.login.visit
  if account == 'admin'
    @app.login.admin_login
  elsif account == 'user'
    @app.login.user_login
  end
end

When(/^I am on the new event page$/) do
  @app.new_event.visit
end

When(/^I set the type of event to (.+)$/) do |type|
  @app.new_event.event_type = type
end

When(/^I fill in the event details (correctly|incorrectly)$/) do |status|
  if status == 'correctly'
    @app.new_event.fill_form EVENT_DETAILS[:event_name], EVENT_DETAILS[:description]
  elsif status == 'incorrectly'
    @app.new_event.submit
  end
end

Then(/^I should see the (.+) event on the Calendar page$/) do
  @app.calendar.visit
  @app.calendar.find_event EVENT_DETAILS[:event_name]
  @app.calendar_day.check_details EVENT_DETAILS[:event_name], EVENT_DETAILS[:description]
end

Then(/^I should be prompted with an error message$/) do
  @app.new_event.check_error
end
