COURSE_NAME = 'Software Engineering'

Given(/^I am logged in as a teacher$/) do
  @app.login.visit
  @app.login.login 'spartatest1', 'Spartatest1!'
end

When(/^I create a new course with (valid|invalid) data/) do |status|
  @app.course_request_page.visit
  if status == 'valid'   
    @app.course_request_page.fill_form fullname: COURSE_NAME, shortname: 'SftEng', summary: 'This course will take you through the wonders of software engineering', reason: 'Reason message'
    raise "Required information is missing, or names are already in use" unless @browser.element(id: 'notice').text.include?('Your course request has been saved successfully')
  else
    @app.course_request_page.submit
  end
end

When(/^the course is approved by an administrator$/) do
  @app.logout
  @app.login.visit
  @app.login.admin_login
  @app.course_pending.visit
  @app.course_pending.approve COURSE_NAME
end

Then(/^I should be able to see it on my list of courses$/) do
  @app.logout
  @app.login.visit
  @app.login.login 'spartatest1', 'Spartatest1!'
  @app.course_search_page.visit 'Software Engineering'
  @app.course_search_page.check_results 'Software Engineering'
end

Then(/^it should not allow me to create the course$/) do
  expect(@browser.url).to eq(@app.course_request_page.url)
end

Then(/^should inform me of what extra information is needed$/) do
  @app.course_request_page.expect_errors fullname: 'Missing full name', shortname:'Missing short name', reason: 'Missing reason'
end
