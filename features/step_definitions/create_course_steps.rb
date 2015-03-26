Given(/^I am logged in as a teacher$/) do
  binding.pry
  pending # express the regexp above with the code you wish you had
end

When(/^I create a new course with valid data$/) do
  @browser.goto 'http://unix.spartaglobal.com/moodle/course/'
  @button.button(value: 'Request a course').click
  @browser.text_field(id: 'id_fullname').set 'Software Enginering'
  @browser.text_field(id: 'id_shortname').set 'SftEng'
  @browser.element(id: 'id_summary_editoreditable').send_keys 'This course will take you through the wonders of software engineering'
  @browser.text_field(id: 'id_reason').set 'Reason message'
  @browser.button(id: 'id_submitbutton').click
  raise "Possibly missing required information" unless expect(browser.element(id: 'notice').text).to include 'Your course request has been saved successfully'
end

Then(/^I should be able to see it on my list of courses$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^it should be able to be seen by a student$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I create a new course with invalid data, missing out required information$/) do
  browser.goto 'http://unix.spartaglobal.com/moodle/course/request.php'
  browser.button(text: 'Request a course').click
end

Then(/^it should not allow me to create the course$/) do
  expect(browser.url).to eq('http://unix.spartaglobal.com/moodle/course/request.php')
end

Then(/^should inform me of what extra information is needed$/) do
  expect(browser.div(id: 'fitem_id_fullname').span(class: 'error').text).to eq('Missing full name')
  expect(browser.div(id: 'fitem_id_shortname').span(class: 'error').text).to eq('Missing short name')
  expect(browser.div(id: 'fitem_id_reason').span(class: 'error').text).to eq('Missing reason')
end

Given(/^I am logged in as a student$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^it should not be possible for me to create a new course$/) do
  pending # express the regexp above with the code you wish you had
end
