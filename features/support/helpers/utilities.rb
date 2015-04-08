# Provides useful helper methods
#-------------------------------------------------------------------------------------------------------------
# Author:      Danny Smith
# Modified:    2013-11-30
#-------------------------------------------------------------------------------------------------------------
module Utilities
  def self.random_string(len)
    (0...len).map{ ('a'..'z').to_a[rand(26)] }.join
  end

  def self.random_email
    "#{random_string(8)}@#{random_string(10)}.com"
  end

  def self.logout(browser)
    browser.goto EnvConfig.base_url + EnvConfig.logout_url
    browser.input(value: 'Continue').click
  end

  def self.login_as_admin(browser)
    browser.goto(EnvConfig.base_url + EnvConfig.login_url)
    browser.text_field(name: 'username').set EnvConfig.admin_username
    browser.text_field(id: 'password').set EnvConfig.admin_password
    browser.form(id: 'login').button.click
  end
end
