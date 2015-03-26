Given(/^I am login as a student$/) do
  @app.login.visit
  @app.login.login 'student1', 'Student1!'
end

When(/^I search for (.+)$/) do |search_term|
  @app.course_page.visit
  @app.course_page.search_for search_term
end

Then(/^I should see a list of result relevent to (.+)$/) do |search_term|
  @app.course_search_page.check_results(search_term)
end
