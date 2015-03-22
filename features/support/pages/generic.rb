class GenericPage
  include RSpec::Matchers
  attr_accessor :browser

  def initialize(browser)
    @browser = browser
  end

  # Expects a watir hash like {:id => "abc"}
  def element_exists?(el)
    @browser.element(el).exists?
  end

  def title
    @browser.title
  end

  def url
    @browser.url
  end

  def logout
    # TODO: It seems like a sensible thing to have this available on GenericPage.
  end
end
