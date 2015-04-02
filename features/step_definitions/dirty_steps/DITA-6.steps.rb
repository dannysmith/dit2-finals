# COURSE_NAME = 'ITA'
# SHORTNAME = 'ITA'
# SUMMARY = 'IT ITA'
# REASON = 'REASON ITA MESSAGE'
# NUM_OF_USERS = 2
# USERNAME1 = 'bob'
# PASSWORD1 = '12345678aB!'
# EMAIL1 = 'bobharris@sharklasers.com'
# EMAIL21 = 'bobharris@sharklasers.com'
# FIRSTNAME1 = 'Bob'
# LASTNAME1 = 'Harris'
# USERNAME2 = 'kate'
# PASSWORD2 = '12345678aB!'
# EMAIL2 = 'katejohnson@sharklasers.com'
# EMAIL22 = 'katejohnson@sharklasers.com'
# FIRSTNAME2 = 'Kate'
# LASTNAME2 = 'Johnson'
# URL = 'http://unix.spartaglobal.com/moodle/course/index.php?categoryid=1'

Given(/^I am signed in as a teacher$/) do
  @app.login.visit
  eventually{ @app.login.login USERNAME1, PASSWORD1 }
end

When(/^I enrol Kate Johnson into the course as a teacher$/) do
  # @browser.goto URL
  # @browser.a(text:COURSE_NAME).click
  # @browser.span(text: "Users").click
  # @browser.a(text: "Enrolled users").click

  #@browser.goto 'http://unix.spartaglobal.com/moodle/enrol/users.php?id=' + courseid
  @app.course_enrol.visit COURSE_ID[:ITA]
  @app.course_enrol.enrol_users_button.click
  @app.course_enrol.assign_role "Teacher"
  @app.course_enrol.enrol 'Kate Johnson'
  @app.course_enrol.finish_enroling_button.click

  # @browser.button(value: "Enrol users").click
  # @browser.select_list(id:"id_enrol_manual_assignable_roles").select("Teacher")
  # @browser.divs(class: 'user').each do |div|
  #   if div.div(class: 'fullname').text == (FIRSTNAME2)+' '+(LASTNAME2)
  #     div.button(class: 'enrol').click
  #     break
  #   end
  # end
  # @browser.button(value: "Finish enrolling users").click
end

Then(/^I should see Kate Johnson in the course as a teacher$/) do
  @app.course_enrol.check_role 'Kate Johnson'
  # @browser.trs(class: 'userinforow').each do |tr|
  #   if tr.div(class: 'subfield subfield_firstname').text == (FIRSTNAME2)+' '+(LASTNAME2)
  #     expect(tr.div(class: "role role_3").text).to eq('Teacher')
  #     break
  #   end
  # end
end