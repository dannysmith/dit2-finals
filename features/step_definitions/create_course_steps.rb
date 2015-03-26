Given(/^I am logged in as a teacher$/) do
  binding.pry
  pending # express the regexp above with the code you wish you had
end

When(/^I create a new course with valid data$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should be able to see it on my list of courses$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^it should be able to be seen by a student$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I create a new course with invalid data, missing out required information$/) do
  pending # express the regexp above with the code you wish you had
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
