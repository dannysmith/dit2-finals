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

Before('@user_setup') do
  unless $user_setup_hook
    @app.signup.visit
    @app.signup.fill_correct 0
    @app.signup.submit.click

    @app.tp_email.visit
    @app.tp_email.account @app.signup.correct_users[0]["email"][/([^@]+)/]
    @app.tp_email.first_li.click
    sleep(3)
    @browser.goto @app.tp_email.email_body.text[/http.+#{@app.signup.correct_users[0]["username"]}/]
    @app.logout
    $user_setup_hook = true
  end
end

Before ('@DITA6_setup') do
  #@app.login.visit
  #@app.login.admin_login

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
  @browser.goto 'http://unix.spartaglobal.com/moodle/course/management.php?categoryid=1'
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

After ('@DITA6_teardown') do
  @app.login.visit
  @app.login.admin_login
  @browser.goto EnvConfig.course_manage_url 
  @browser.as(class: 'coursename').each_with_index do |course, i|
    if course.text == COURSE_NAME
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

  if $user_setup_hook
    @app.login.visit
    @app.login.admin_login
    @browser.goto EnvConfig.modify_users_url 
    name = EnvConfig.data['Correct'][0]["firstname"]+" "+EnvConfig.data['Correct'][0]["lastname"]
    @browser.option(text:name).select
    @browser.button(id:'id_addsel').click

    @browser.option(text:'Delete').select
    @browser.button(id:'id_doaction').click
    @browser.button(value:'Yes').click
  end

  browser.close

  if ENV['HEADLESS']
    headless.destroy
  end
end
