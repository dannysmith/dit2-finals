require_relative "../async_support.rb"

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
    sleep(3)
  end

  def first_li
    AsyncSupport.eventually{
      @browser.tr(class: 'email_unread').td(class:'td2').text == 'admin@spartaglobal.com'
      @browser.tr(class: 'email_unread').td(class:'td3').span.text == 'A new account has been requested at \'Spartiaite LMS\' using your email address.'
    }
    @browser.tr
  end

  def email_body
    AsyncSupport.eventually{ @browser.div(ELEMENT[:email_content]).text.include? 'admin@spartaglobal.com'}
    @browser.div(ELEMENT[:email_content])
  end

end
