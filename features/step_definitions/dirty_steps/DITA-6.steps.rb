COURSE_ID = {}

Given(/^I am signed in as a teacher$/) do
  @app.login.visit
  @app.login.login 'bob', '12345678aB!'
end

When(/^I enrol Kate Johnson into the course as a teacher$/) do
  @app.course_enrol.visit COURSE_ID[:ITA]
  @app.course_enrol.enrol_users_button.click
  @app.course_enrol.assign_role "Teacher"
  @app.course_enrol.enrol 'Kate', 'Johnson'
  @app.course_enrol.finish_enroling_button.click
end

Then(/^I should see Kate Johnson in the course as a teacher$/) do
  expect(@app.course_enrol.check_role 'Kate Johnson').to eq('Teacher')
end