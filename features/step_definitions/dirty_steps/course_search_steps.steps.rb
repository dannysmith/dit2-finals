Given(/^I am login as a student$/) do
  @app.login.visit
  @app.login.login 'student1', 'Student1!'
end

When(/^I search for (.+)$/) do |search_term|
  @app.course_page.visit
  @app.course_page.search= search_term
end

Then(/^I should see a list of results for this course$/) do
  pending # express the regexp above with the code you wish you had
end
