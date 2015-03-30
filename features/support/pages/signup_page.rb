class SignUpPage < GenericPage

  ELEMENT = {
    error: {class: "error"},
    submit: {id:'id_submitbutton'},
    username: {id:'id_username'},
    password: {id:'id_password'},
    email: {id:'id_email'},
    email2: {id:'id_email2'},
    firstname: {id:'id_firstname'},
    lastname: {id:'id_lastname'},
    form: {id: "region-main"}
  }
  
  DATA = {
    correct_users: EnvConfig.data['Correct'],
    incorrect_users: EnvConfig.data['Incorrect'],
    error_text: EnvConfig.data['Error']
  }
  def visit
    @browser.goto EnvConfig.signup_url
  end

  def correct_users
    DATA[:correct_users]
  end

  def incorrect_users
    DATA[:incorrect_users]
  end

  def first_error
    @browser.span(ELEMENT[:error_text]).text
  end

  def submit
    @browser.button(ELEMENT[:submit])
  end

  def fill_correct(n)    
    @browser.text_field(ELEMENT[:username]).set DATA[:correct_users][n]['username']
    @browser.text_field(ELEMENT[:password]).set DATA[:correct_users][n]['password']
    @browser.text_field(ELEMENT[:email]).set DATA[:correct_users][n]['email']
    @browser.text_field(ELEMENT[:email2]).set DATA[:correct_users][n]['email2']
    @browser.text_field(ELEMENT[:firstname]).set DATA[:correct_users][n]['firstname']
    @browser.text_field(ELEMENT[:lastname]).set DATA[:correct_users][n]['lastname']
  end

  def fill_incorrect(n)   
    @browser.text_field(ELEMENT[:username]).set DATA[:incorrect_users][n]['username']
    @browser.text_field(ELEMENT[:password]).set DATA[:incorrect_users][n]['password']
    @browser.text_field(ELEMENT[:email]).set DATA[:incorrect_users][n]['email']
    @browser.text_field(ELEMENT[:email2]).set DATA[:incorrect_users][n]['email2']
    @browser.text_field(ELEMENT[:firstname]).set DATA[:incorrect_users][n]['firstname']
    @browser.text_field(ELEMENT[:lastname]).set DATA[:incorrect_users][n]['lastname']
  end

  def error_form
    bool = false
    DATA[:error_text].each_with_index do |x,i|
      bool = true if @browser.div(ELEMENT[:form]).text.include?(DATA[:error_text][i])
    end
    return bool
  end
end
