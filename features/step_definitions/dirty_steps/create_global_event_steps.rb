Given(/^I am logged in as admin$/) do
  @app.login.visit
  @app.login.admin_login
end

When(/^I am on the new event page$/) do
  @app.new_event.visit
end

When(/^I set the type of event to (.+)$/) do |type|
  @app.new_event.event_type = type
end

When(/^I fill in the event details (correctly|incorrectly)$/) do |status|
  @app.new_event.fill_form status
end

Then(/^I should see the global event on the Calendar page$/) do
  @app.calendar.visit
  @app.calendar.check_event
end

Then(/^I should be prompted with an error message$/) do
  @app.new_event.check_error
end