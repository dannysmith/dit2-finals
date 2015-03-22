# Used for visiting home page
#-------------------------------------------------------------------------------------------------------------
# Author:    Danny Smith
# Modified:  2015-03-22
#-------------------------------------------------------------------------------------------------------------
class HomePage < GenericPage

  def visit
    @browser.goto EnvConfig.base_url
  end

end
