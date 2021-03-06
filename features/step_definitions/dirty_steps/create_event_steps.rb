EVENT_DETAILS = {
  event_name: 'Test Event',
  description: 'This is a test event'
}

EVENT_USER_DETAILS = {
  user1: {
    username: 'nininidita40',
    password: 'Jewootah1!',
    email: 'neermaldita40@sharklasers.com',
    firstname: 'Neermal',
    lastname: 'DITA40'
  },
  user2: {
    username: 'richarddita40',
    password: 'Twenaaa1!',
    email: 'rtwenadita40@sharklasers.com',
    firstname: 'Richard',
    lastname: 'DITA40'
  },
  user3: {
    username: 'modita40',
    password: 'Twenaaa1!',
    email: 'modita40@sharklasers.com',
    firstname: 'Mo',
    lastname: 'DITA40'
  },
  user4: {
    username: 'ericdita40',
    password: 'Twenaaa1!',
    email: 'ericdita40@sharklasers.com',
    firstname: 'Eric',
    lastname: 'DITA40'
  }
}

EVENT_COURSE_DETAILS = {
  course1: {
    fullname: "DITA40 DITA40",
    shortname: "DITA40",
    summary: "Engineer course",
    reason: "nerds"
  }
}

COURSE_ID = {}

Given(/^I am logged in as (admin|teacher|grouped student|enrolled student|student)$/) do |account|
  @app.login.visit
  if account == 'admin'
    @app.login.admin_login
  elsif account == 'grouped student'
    @app.login.login EVENT_USER_DETAILS[:user1][:username], EVENT_USER_DETAILS[:user1][:password]
  elsif account == 'teacher'
    @app.login.login EVENT_USER_DETAILS[:user2][:username], EVENT_USER_DETAILS[:user2][:password]
  elsif account == 'enrolled student'
    @app.login.login EVENT_USER_DETAILS[:user3][:username], EVENT_USER_DETAILS[:user3][:password]
  elsif account == 'student'
    @app.login.login EVENT_USER_DETAILS[:user4][:username], EVENT_USER_DETAILS[:user4][:password]
  end
end

When(/^I am on the (.+) event page$/) do |type|
  if type == 'new'
    @app.new_event.visit
  elsif type == 'course'
    @app.new_event.visit_with COURSE_ID[(EVENT_COURSE_DETAILS[:course1][:fullname]).to_sym]
  end
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

Given(/^a group exists$/) do
  @app.create_group.visit COURSE_ID[(EVENT_COURSE_DETAILS[:course1][:fullname]).to_sym]
  @app.create_group.submit_form "Test Group"
  @app.group.select_add_members
  @app.create_member.submit_form EVENT_USER_DETAILS[:user1][:firstname], EVENT_USER_DETAILS[:user2][:firstname]
end

Then(/^I should not see the (?:.+) event on the Calendar page$/) do
  @app.calendar.visit
  @app.calendar.check_exist(EVENT_DETAILS[:event_name]) == false
end
