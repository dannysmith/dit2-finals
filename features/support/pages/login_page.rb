class LoginPage < GenericPage
  def visit
    @browser.goto EnvConfig.login_url
  end

  def login(username, password)
    self.username= username
    self.password= password
    self.click_login_button
  end

  def username=(username)
    @browser.text_field(name: 'username').set username
  end

  def password=(password)
    @browser.text_field(id: 'password').set password
  end

  def click_login_button
    @browser.form(id: 'login').button.click
  end

  def admin_login
    self.login EnvConfig.admin_username, EnvConfig.admin_password
  end
end
