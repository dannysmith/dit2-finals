# Object Representing Coures in the Moddle Interface
# -----------------------------------------------------------------------------
# Authors: Nini Jewootah (njewootah@spartaglobal.com) & Danny Smith (dsmith@testingcircle.com)
# Date Modified: 2015-04-08
# -----------------------------------------------------------------------------

class User
  attr_reader :username, :password, :firstname, :lastname, :email, :id

  @@users = []

  def initialize(browser, params = {})

    details = {
      firstname: 'User',
      lastname: "Dita #{Utilities.random_string(5).capitalize}",
      email: "#{Utilities.random_string(5)}@sharklasers.com",
      password: "Password1!"
    }

    # Merge details with parameters
    details.merge!(params)

    # Create a username if one isn't provided
    details[:username] ||= (details[:firstname] + details[:lastname] + rand(999).to_s).gsub(' ', '-').downcase

    @browser = browser

    @username = details[:username]
    @password = details[:password]
    @firstname = details[:firstname]
    @lastname = details[:lastname]
    @email = details[:email]

    # Creating the user in Watir
    submit_form
    verify_email
    @id = capture_id
    Utilities.logout @browser

    # Inserts instance variables into the class array
    @@users << self
  end

  def delete!
    Utilities.login_as_admin @browser
    @browser.goto EnvConfig.base_url + EnvConfig.modify_users_url
    @browser.option(value: @id).select
    @browser.input(value: "Add to selection").click
    @browser.option(text: "Delete").select
    @browser.input(value: "Go").click
    @browser.input(value: "Yes").click
    Utilities.logout @browser

    # Deletes the object from the class array
    @@users.delete self
  end

  def login
    Utilities.login(@browser, @username, @password)
  end

  def self.all
    @@users
  end

  def self.last
    @@users.last
  end

  private

  def capture_id
    @browser.a(title:"View profile").attribute_value('href')[/\d+/]
  end

  def submit_form
    @browser.goto EnvConfig.base_url + EnvConfig.signup_url
    @browser.text_field(id:'id_username').value = @username
    @browser.text_field(id:'id_password').value = @password
    @browser.text_field(id:'id_email').value = @email
    @browser.text_field(id:'id_email2').value = @email
    @browser.text_field(id:'id_firstname').value = @firstname
    @browser.text_field(id:'id_lastname').value = @lastname
    @browser.button(id:'id_submitbutton').click
  end

  def verify_email
    @browser.goto EnvConfig.third_party_email_url
    @browser.span(id:"inbox-id").click
    @browser.span(id:"inbox-id").text_field.set @email[/([^@]+)/]
    @browser.button(class: "save button small").click

    sleep(10)
    AsyncSupport.eventually{@browser.tr(class: 'email_unread').td(class:'td2').text == 'admin@spartaglobal.com'}
    @browser.tr

    AsyncSupport.eventually{ @browser.div(id: "display_email").text.include? 'admin@spartaglobal.com'}
    @browser.tbody(id: 'email_list').td(class: 'td2').click
    @browser.goto @browser.div(id: "display_email").text[/http.+#{@username}/]
  end
end
