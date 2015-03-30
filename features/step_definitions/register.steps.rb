Given(/^I am on the sign up page$/) do
  @app.signup.visit
end

When(/^I fill in the form correctly$/) do
  @app.signup.correct_users.each_with_index do |_user, i|
    @app.signup.fill_correct i
    @app.signup.submit.click
    @app.signup.visit
  end
end

Then(/^I should receive an email to verify my account$/) do
  @app.tp_email.visit
  @app.signup.correct_users.each_with_index do |_user, i|  
    sleep(5)  
    @app.tp_email.account @app.signup.correct_users[i]["email"][/([^@]+)/]
    @app.tp_email.first_li.click
    sleep(3)
    expect(@app.tp_email.email_body.text).to include "A new account has been requested at \'Spartiaite LMS\'"
  end
end

When(/^I fill in the form incorrectly$/) do 
  @app.signup.fill_incorrect 0
  @app.signup.submit.click
end

Then(/^I should see error texts for each incorrect field$/) do
  raise "No errors found for user details #{i}, found possible errors #{@app.signup.first_error}" unless @app.signup.error_form
  @app.signup.incorrect_users.each_with_index do |_user,i|
    @app.signup.fill_incorrect i
    @app.signup.submit.click
    raise "No errors found for user details #{i}, found possible errors #{@app.signup.first_error}" unless @app.signup.error_form
  end
end
