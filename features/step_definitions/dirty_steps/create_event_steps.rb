EVENT_DETAILS = {
  event_name: 'Test Event',
  description: 'This is a test event'
}

USER_DETAILS = {
  user1: {
    username: 'njewootah',
    password: 'Jewootah1!',
    email: 'nini@sharklasers.com',
    firstname: 'Nini',
    lastname: 'Jewootah'
  },
  user2: {
    username: 'richard',
    password: 'Twenaaa1!',
    email: 'rtwena@sharklasers.com',
    firstname: 'Richard',
    lastname: 'Twena'
  }
}

COURSE_DETAILS = {
  course1: {
    fullname: "Computer Science",
    shortname: "CScience",
    summary: "Engineer course",
    reason: "nerds"
  }
}

Given(/^I am logged in as (admin|user)$/) do |account|
  @app.login.visit
  if account == 'admin'
    @app.login.admin_login
  elsif account == 'user'
    @app.login.login USER_DETAILS[:user1][:username], USER_DETAILS[:user1][:password]
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

Then(/^I should see the (?:.+) event on the Calendar page$/) do
  @app.calendar.visit
  @app.calendar.find_event EVENT_DETAILS[:event_name]
  @app.calendar_day.check_details EVENT_DETAILS[:event_name], EVENT_DETAILS[:description]
end

Then(/^I should be prompted with an error message$/) do
  @app.new_event.check_error
end

Given(/^a student is enrolled on my course$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^a group exists$/) do
  pending # Write code here that turns the phrase above into concrete actions
end
