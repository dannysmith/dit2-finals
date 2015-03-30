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

After ('@course_teardown') do
  @app.login.visit
  @app.login.admin_login
  @browser.goto 'http://unix.spartaglobal.com/moodle/course/management.php?categoryid=1'
  @browser.as(class: 'coursename').each_with_index do |course, index|
    if course.text == COURSE_NAME
      @browser.imgs(alt: 'Delete')[index].click
      @browser.input(value: 'Continue').click
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

  browser.close

  if ENV['HEADLESS']
    headless.destroy
  end
end
