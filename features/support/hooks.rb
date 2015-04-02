# Use the headless gem if we've set the HEADLESS var to true
if ENV['HEADLESS']
  require 'headless'
  headless = Headless.new :display => '100'
  headless.start
end

# Set up browser
browser = Watir::Browser.new (ENV['BROWSER'] || 'firefox').to_sym
$setup_done = false

Before do
  @browser = browser
  @browser.cookies.clear

  @app = App.new @browser

  unless $setup_done
    $setup_done = true
    # This stuff will only run before the first scenario executed. Use it to set up data etc.
  end
end

# Registering 2 users
# Enrolling 1 user
# 1 user shall create a course
Before ('@user_register_enrollment') do
  unless $user_register_enrollment_hook
    user_setup(USER_DETAILS)
    @app.login.visit
    @app.login.login USER_DETAILS[:user2][:username], USER_DETAILS[:user2][:password]
    course_setup(COURSE_DETAILS)
    @app.login.visit
    @app.login.admin_login
    setup_enrollment((USER_DETAILS[:user1][:firstname])+' '+(USER_DETAILS[:user1][:lastname]), 'Student', COURSE_DETAILS[:course1])
    $user_register_enrollment_hook= true
  end
end

Before ('@setup course') do
  unless $multiple_users_setup_hook
    course_setup(COURSE_DETAILS)
    $multiple_users_setup_hook= true
  end
end

def user_setup(user_details)
  @app.signup.visit
  user_details.each do |key, user|
    @app.signup.username = user[:username]
    @app.signup.password = user[:password]
    @app.signup.email = user[:email]
    @app.signup.email2 = user[:email]
    @app.signup.firstname = user[:firstname]
    @app.signup.lastname = user[:lastname]
    @app.signup.submit.click
    @app.tp_email.visit
    @app.tp_email.account(user[:email][/([^@]+)/])
    @app.tp_email.first_li.click
    @browser.goto @app.tp_email.email_body.text[/http.+#{user[:username]}/]
    @app.logout
    @app.signup.visit
  end
end

# Teacher account MUST exist
def course_setup(course_details)
  @app.course_request_page.visit
  course_details.each do |key, course|
    @app.course_request_page.fill_form fullname: course[:fullname], shortname: course[:shortname], summary: course[:summary], reason: course[:reason]
    @app.course_request_page.visit
  end
  @app.logout
  @app.login.visit
  @app.login.admin_login
  course_details.each do |key, course|
    @app.course_pending.visit
    @app.course_pending.approve course[:fullname]
    COURSE_ID[course[:fullname].to_sym] = @app.course_approved.get_course_id
  end
  @app.logout
end

# Teacher account MUST exist
# def course_setup(course_details)
#   @app.course_request_page.visit
#   course_details.each do |_key, course|
#     @app.course_request_page.fill_form fullname: course[:fullname], shortname: course[:shortname], summary: course[:summary], reason: course[:reason]
#     @app.course_request_page.visit
#   end
#   @app.logout
#   @app.login.visit
#   @app.login.admin_login
#   course_details.each do |_key, course|
#     @app.course_pending.visit
#     @app.course_pending.approve course[:fullname]
#   end
#   @app.logout
# end

def setup_enrollment(enroll_user, enroll_type, course)
  @browser.goto EnvConfig.course_manage_url
  @browser.a(text: course[:fullname]).click
  @browser.a(text: "Enrolled users").click
  @browser.button(value: "Enrol users").click
  @browser.select_list(id:"id_enrol_manual_assignable_roles").select(enroll_type)
  @browser.divs(class: 'user').each do |user|
    if user.div(class: 'fullname').text == enroll_user
      user.button(class: 'enrol').click
      break
    end
  end
  @app.logout
end

def delete_users(user_details)
  @app.login.visit
  @app.login.admin_login
  @browser.goto EnvConfig.modify_users_url
  user_details.each do |_key, users|
    @browser.option(text: users[:firstname] + ' ' + users[:lastname]).select
  end
  @browser.input(value: "Add to selection").click
  @browser.option(text: "Delete").select
  @browser.input(value: "Go").click
  @browser.input(value: "Yes").click
  @app.logout
end

def delete_courses(course_details)
  @app.login.visit
  @app.login.admin_login
  @browser.goto EnvConfig.course_manage_url
  course_details.each do |_key, course_name|
    @browser.as(class: "coursename").each_with_index do |courses, i|
      if courses.text == course_name[:fullname]
        @browser.imgs(alt: 'Delete')[i].click
        @browser.input(value: 'Continue').click
        break
      end
    end
  end
  @app.logout
end

def delete_courses_ID(course_IDs)
  @app.login.visit
  @app.login.admin_login
  @browser.goto 'http://unix.spartaglobal.com/moodle/course/management.php?categoryid=1'
  course_IDs.each do |key, course_id|
    @browser.goto "http://unix.spartaglobal.com/moodle/course/delete.php?id=#{course_id}"
    @browser.button(value: 'Continue').click
  end
  @app.logout
end

Before ('@DITA6_setup') do
  # @app.login.visit
  # @app.login.admin_login

  @app.signup.visit
  @app.signup.username.set USERNAME1
  @app.signup.password.set PASSWORD1
  @app.signup.email.set EMAIL1
  @app.signup.email2.set EMAIL21
  @app.signup.firstname.set FIRSTNAME1
  @app.signup.lastname.set LASTNAME1
  @app.signup.submit.click

  if (NUM_OF_USERS == 2)
    @app.signup.visit
    @app.signup.username.set USERNAME2
    @app.signup.password.set PASSWORD2
    @app.signup.email.set EMAIL2
    @app.signup.email2.set EMAIL22
    @app.signup.firstname.set FIRSTNAME2
    @app.signup.lastname.set LASTNAME2
    @app.signup.submit.click
  end
  
  if (NUM_OF_USERS == 2)
    @app.tp_email.visit
    @app.tp_email.account (EMAIL2)[/([^@]+)/]
    sleep(3)
    @app.tp_email.first_li.click
    sleep(3)
    @browser.goto @app.tp_email.email_body.text[/http.+#{USERNAME2}/]
  end

  @app.tp_email.visit
  @app.tp_email.account (EMAIL1)[/([^@]+)/]
  sleep(3)
  @app.tp_email.first_li.click
  sleep(3)
  @browser.goto @app.tp_email.email_body.text[/http.+#{USERNAME1}/]

  @app.course_request_page.visit 
  @app.course_request_page.fill_form fullname: COURSE_NAME, shortname: SHORTNAME, summary: SUMMARY, reason: REASON
  @browser.a(title:(FIRSTNAME1)+' '+(LASTNAME1)).click
  @browser.a(title:'Log out').click
  @app.login.visit
  @app.login.admin_login
  @browser.goto 'http://unix.spartaglobal.com/moodle/course/pending.php'
  @browser.tbody.trs.each do |row|
    if row.tds[1].text == COURSE_NAME
      row.input(value: 'Approve').click
      break
    end
  end
  @browser.goto EnvConfig.course_manage_url
  @browser.a(text: COURSE_NAME).click
  @browser.a(text: "Enrolled users").click
  @browser.button(value: "Enrol users").click
  @browser.select_list(id:"id_enrol_manual_assignable_roles").select("Teacher")
  @browser.divs(class: 'users').each do |div|
    if div.div(class: 'fullname').text == (FIRSTNAME1)+' '+(LASTNAME1)
      div.button(class: 'enroll').click
      break
    end
  end
  @browser.a(title:'Admin User').click
  @browser.a(title:'Log out').click
end

# Registering 2 users
# Enrolling 1 user
# 1 user shall create a course
Before ('@user_register_enrollment') do
  unless $multiple_users_setup_hook
    user_setup(USER_DETAILS)
    @app.login.visit
    @app.login.login USER_DETAILS[:user2][:username], USER_DETAILS[:user2][:password]
    course_setup(COURSE_DETAILS)
    binding.pry
    @app.login.visit
    @app.login.admin_login
    binding.pry
    setup_enrollment((USER_DETAILS[:user1][:firstname])+' '+(USER_DETAILS[:user1][:lastname]), 'Student', COURSE_DETAILS[:course1])
    binding.pry
    $multiple_users_setup_hook= true
  end
end

Before ('@user_course_setup') do
  unless $user_course_setup
    user_setup(USER_DETAILS)
    @app.login.visit
    @app.login.login USER_DETAILS[:user2][:username], USER_DETAILS[:user2][:password]
    course_setup(COURSE_DETAILS)
    $user_course_setup = true
  end
end

Before ('@DITA6_setup') do
  user1 = {username:'bob', password:'12345678aB!', email:'bobharris@sharklasers.com', firstname:'Bob', lastname:'Harris'}
  user2  = {username: 'kate', password:'12345678aB!', email:'katejohnson@sharklasers.com', firstname:'Kate', lastname:'Johnson'}
  user_setup ({user1: user1, user2: user2})
  @app.login.visit
  @app.login.login 'bob', '12345678aB!'
  course_setup ({course1:{fullname: 'ITA', shortname: 'ITA', summary: 'IT ITA', reason: 'REASON ITA MESSAGE'}})
  @app.login.visit
  @app.login.admin_login
  setup_enrollment('Bob Harris', 'Teacher', {fullname: 'ITA'})
end

After ('@DITA6_teardown') do
  @app.login.visit
  @app.login.admin_login
  @browser.goto EnvConfig.course_manage_url 
  @browser.as(class: 'coursename').each_with_index do |course, i|
    if course.text == 'ITA'
      @browser.imgs(alt: 'Delete')[i].click
      @browser.input(value: 'Continue').click
      break
    end
  end
  @browser.goto EnvConfig.modify_users_url
  @browser.option(text:'Kate Johnson').select
  @browser.button(id:'id_addsel').click
  @browser.option(text:'Bob Harris').select
  @browser.button(id:'id_addsel').click
  @browser.option(text:'Delete').select
  @browser.button(id:'id_doaction').click
  @browser.button(value:'Yes').click
  @browser.button(value:'Continue').click    
end

After ('@course_teardown') do
  @app.login.visit
  @app.login.admin_login

  @browser.goto EnvConfig.course_manage_url 
  @browser.as(class: 'coursename').each_with_index do |course, i|
    if course.text == 'Maths'
      @browser.imgs(alt: 'Delete')[i].click
      @browser.input(value: 'Continue').click
      break
    end
  end
  @browser.goto EnvConfig.modify_users_url
  if (NUM_OF_USERS == 2)
    @browser.option(text:(FIRSTNAME2)+' '+(LASTNAME2)).select
    @browser.button(id:'id_addsel').click
  end
  @browser.option(text:(FIRSTNAME1)+' '+(LASTNAME1)).select
  @browser.button(id:'id_addsel').click
  @browser.option(text:'Delete').select
  @browser.button(id:'id_doaction').click
  @browser.button(value:'Yes').click
  @browser.button(value:'Continue').click    
end

After ('@event_teardown') do
  @app.login.visit
  @app.login.admin_login
  @app.calendar.visit
  @app.calendar.find_event EVENT_DETAILS[:event_name]
  @browser.div(class: 'name').wait_until_present
  @browser.divs(class: 'name').each_with_index do |event, i|
    if event.text == EVENT_DETAILS[:event_name]
      @browser.imgs(alt: 'Delete event')[i].click
      @browser.input(value: 'Delete').click
      break
    end
  end
end

After ('@new_user_teardown') do
  @app.login.visit
  @app.login.admin_login
  @browser.goto EnvConfig.modify_users_url 
  EnvConfig.data['Correct'].each_with_index do |_u, i|
    name = EnvConfig.data['Correct'][i]["firstname"]+" "+EnvConfig.data['Correct'][i]["lastname"]
    @browser.option(text:name).select
    @browser.button(id:'id_addsel').click
  end
  @browser.option(text:'Delete').select
  @browser.button(id:'id_doaction').click
  @browser.button(value:'Yes').click
  @browser.button(value:'Continue').click
  @browser.goto EnvConfig.third_party_email_url
  EnvConfig.data['Correct'].each_with_index do |_u, i|
    @browser.span(id:"inbox-id").click    
    @browser.span(id:"inbox-id").text_field.set EnvConfig.data['Correct'][i]["email"][/([^@]+)/]
    @browser.button(class: "save button small").click
    sleep(2)
    while @browser.checkbox(name:"mid[]").exists? do
      @browser.checkbox(name:"mid[]").set true
      @browser.button(id:"del_button").click
      sleep(1)
    end
  end  
end

After('@event_calendar') do
  unless condition
    
  end
end

After do |scenario|

  @browser.driver.manage.delete_all_cookies

  # Output a screenshot (and video if HEADLESS) if the scenario failed
  if scenario.failed?
    output_path = File.expand_path(File.dirname(__FILE__) + '/../../results/screenshots/')
    scenario_name =  "#{Time.now.strftime("%Y%m%d-%H_%M_%S")}-#{scenario.to_sexp[3].gsub(/[^\w\-]/, '-')}"
    output_path += '/' + scenario_name
    browser.screenshot.save "#{output_path}.png"

    image = browser.screenshot.base64
    embed "data:image/png;base64,#{image}",'image/png'

  end
end

# After all features have executed
at_exit do

  @browser = browser
  @app = App.new @browser

  # if $user_setup_hook
  #   @app.login.visit
  #   @app.login.admin_login
  #   @browser.goto EnvConfig.modify_users_url 
  #   name = EnvConfig.data['Correct'][0]["firstname"]+" "+EnvConfig.data['Correct'][0]["lastname"]
  #   @browser.option(text:name).select
  #   @browser.button(id:'id_addsel').click

  #   @browser.option(text:'Delete').select
  #   @browser.button(id:'id_doaction').click
  #   @browser.button(value:'Yes').click
  # end

  if $user_course_setup
    # @app.login.visit
    # @app.login.admin_login
    # @browser.goto "http://unix.spartaglobal.com/moodle/course/delete.php?id=#{COURSE_ID[(COURSE_DETAILS[:course1][:fullname]).to_sym]}"
    # @browser.button(value: 'Continue').click
    # @browser.goto "http://unix.spartaglobal.com/moodle/course/delete.php?id=#{COURSE_ID[(COURSE_DETAILS[:course2][:fullname]).to_sym]}"
    # @browser.button(value: 'Continue').click
    delete_users(USER_DETAILS)
    delete_courses_ID(COURSE_ID)
    # @browser.goto 'http://unix.spartaglobal.com/moodle/admin/user/user_bulk.php'
    # @browser.option(text: (USER_DETAILS[:user1][:firstname]+" "+USER_DETAILS[:user1][:lastname])).select
    # @browser.option(text: (USER_DETAILS[:user2][:firstname]+" "+USER_DETAILS[:user2][:lastname])).select
    # @browser.button(id: 'id_addsel').click
    # @browser.option(text:'Delete').select
    # @browser.button(id:'id_doaction').click
    # @browser.button(value:'Yes').click
  end

  if $user_register_enrollment_hook
    delete_courses_ID(COURSE_ID)
    delete_users(USER_DETAILS)
  end

  browser.close

  if ENV['HEADLESS']
    headless.destroy
  end
end
