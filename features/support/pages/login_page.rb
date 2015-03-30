class LoginPage < GenericPage
  ELEMENT = {
    username: {name: 'username'},
    password: {id: 'password'},
    login: {id: 'login'}
  }
  
  def visit
    @browser.goto EnvConfig.login_url
  end

  def login(username, password)
    self.username= username
    self.password= password
    self.click_login_button
  end

  def username=(username)
    @browser.text_field(ELEMENT[:username]).set username
  end

  def password=(password)
    @browser.text_field(ELEMENT[:password]).set password
  end

  def click_login_button
    @browser.form(ELEMENT[:login]).button.click
  end

  def admin_login
    self.login EnvConfig.admin_username, EnvConfig.admin_password
  end
end
