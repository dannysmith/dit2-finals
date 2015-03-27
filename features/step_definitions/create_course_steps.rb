Given(/^I am logged in as a teacher$/) do
  @app.login.visit
  @app.login.login 'spartatest1', 'Spartatest1!'
end

When(/^I create a new course with valid data$/) do
  @app.course_request_page.visit
  @app.course_request_page.fill_form 'Software Enginering1234', 'SftEng1243', 'This course will take you through the wonders of software engineering', 'Reason message'
  raise "Possibly missing required information" unless @browser.element(id: 'notice').text.include?('Your course request has been saved successfully')
end

When(/^the course is approved by an administrator$/) do

end

Then(/^I should be able to see it on my list of courses$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^it should be able to be seen by a student$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I create a new course with invalid data, missing out required information$/) do
  pending # express the regexp above with the code you wish you had
  # browser.goto 'http://unix.spartaglobal.com/moodle/course/request.php'
  # browser.button(text: 'Request a course').click
end

Then(/^it should not allow me to create the course$/) do
  pending # express the regexp above with the code you wish you had
  # expect(@browser.url).to eq('http://unix.spartaglobal.com/moodle/course/request.php')
end

Then(/^should inform me of what extra information is needed$/) do
  pending # express the regexp above with the code you wish you had
  # expect(@browser.div(id: 'fitem_id_fullname').span(class: 'error').text).to eq('Missing full name')
  # expect(@browser.div(id: 'fitem_id_shortname').span(class: 'error').text).to eq('Missing short name')
  # expect(@browser.div(id: 'fitem_id_reason').span(class: 'error').text).to eq('Missing reason')
end

Given(/^I am logged in as a student$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^it should not be possible for me to create a new course$/) do
  pending # express the regexp above with the code you wish you had
end
