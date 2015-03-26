class LoginPage < GenericPage
  def visit
    @browser.goto "http://unix.spartaglobal.com/moodle/login/"
  end

  def login(username, password)
    username= username
    password= password
    click_login_button
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
end
