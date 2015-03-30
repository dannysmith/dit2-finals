class ThirdPartyEmail < GenericPage
  ELEMENT = {
    email_account: {id:"inbox-id"},
    email_confirm: {class: "save button small"},
    email_content: {id: "display_email"}
  }
  def visit
    @browser.goto EnvConfig.third_party_email_url
  end

  def account (account)
    @browser.span(ELEMENT[:email_account]).click    
    @browser.span(ELEMENT[:email_account]).text_field.set account[/([^@]+)/]
    @browser.button(ELEMENT[:email_confirm]).click
  end

  def account (account)
    @browser.span(id:"inbox-id").click    
    @browser.span(id:"inbox-id").text_field.set account[/([^@]+)/]
    @browser.button(class: "save button small").click
  end

  def first_li
    sleep(3)
    @browser.tr
  end

  def email_body
    @browser.div(ELEMENT[:email_content])
  end
end

