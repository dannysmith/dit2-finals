EVENT_DETAILS = {
  event_name: 'Test Event',
  description: 'This is a test event'
}

USER_DETAILS = {
  user1: {
    username: 'njewootahdita40',
    password: 'Jewootah1!',
    email: 'ninidita40@sharklasers.com',
    firstname: 'Nini',
    lastname: 'DITA40'
  },
  user2: {
    username: 'richarddita40',
    password: 'Twenaaa1!',
    email: 'rtwenadita40@sharklasers.com',
    firstname: 'Richard',
    lastname: 'DITA40'
  }
}

COURSE_DETAILS = {
  course1: {
    fullname: "DITA40 DITA40",
    shortname: "DITA40",
    summary: "Engineer course",
    reason: "nerds"
  }
}

Given(/^I am logged in as (admin|user)$/) do |account|
  @app.login.visit
  if account == 'admin'
    @app.login.admin_login
  elsif account == 'user'
    @app.login.login USER_DETAILS[:user2][:username], USER_DETAILS[:user2][:password]
  end
end

When(/^I am on the (.+) event page$/) do |type|
  if type == 'new'
    @app.new_event.visit
  elsif type == 'course'
    @app.new_event.visit COURSE_ID
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
  @app.my_course.visit
  COURSE_ID = @app.my_course.get_course_id COURSE_DETAILS[:course1][:fullname]
  @app.create_group.visit COURSE_ID
  @app.create_group.submit_form "Test Group"
  @app.group.select_add_members
  @app.create_member.submit_form USER_DETAILS[:user1][:firstname], USER_DETAILS[:user2][:firstname]

  # DELETE COURSE DETAILS (GOES TO USERS THEN GROUPS)
end
