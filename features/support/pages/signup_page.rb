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
    @browser.goto EnvConfig.base_url + EnvConfig.signup_url
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

  def username
    @browser.text_field(ELEMENT[:username])
  end

  def password
    @browser.text_field(ELEMENT[:password])
  end

  def email
    @browser.text_field(ELEMENT[:email])
  end

  def email2
    @browser.text_field(ELEMENT[:email2])
  end

  def firstname
    @browser.text_field(ELEMENT[:firstname])
  end

  def lastname
    @browser.text_field(ELEMENT[:lastname])
  end

  def fill_correct(n)    
    @browser.text_field(ELEMENT[:username]).value= DATA[:correct_users][n]['username']
    @browser.text_field(ELEMENT[:password]).value= DATA[:correct_users][n]['password']
    @browser.text_field(ELEMENT[:email]).value= DATA[:correct_users][n]['email']
    @browser.text_field(ELEMENT[:email2]).value= DATA[:correct_users][n]['email2']
    @browser.text_field(ELEMENT[:firstname]).value= DATA[:correct_users][n]['firstname']
    @browser.text_field(ELEMENT[:lastname]).value= DATA[:correct_users][n]['lastname']
  end

  def fill_incorrect(n)   
    @browser.text_field(ELEMENT[:username]).value= DATA[:incorrect_users][n]['username']
    @browser.text_field(ELEMENT[:password]).value= DATA[:incorrect_users][n]['password']
    @browser.text_field(ELEMENT[:email]).value= DATA[:incorrect_users][n]['email']
    @browser.text_field(ELEMENT[:email2]).value= DATA[:incorrect_users][n]['email2']
    @browser.text_field(ELEMENT[:firstname]).value= DATA[:incorrect_users][n]['firstname']
    @browser.text_field(ELEMENT[:lastname]).value= DATA[:incorrect_users][n]['lastname']
  end

  def username=(username)
    @browser.text_field(ELEMENT[:username]).value = username
  end

  def password=(password)
    @browser.text_field(ELEMENT[:password]).value = password
  end

  def email=(email)
    @browser.text_field(ELEMENT[:email]).value = email
  end

  def email2=(email2)
    @browser.text_field(ELEMENT[:email2]).value = email2
  end

  def firstname=(firstname)
    @browser.text_field(ELEMENT[:firstname]).value = firstname
  end

  def lastname=(lastname)
    @browser.text_field(ELEMENT[:lastname]).value = lastname
  end

  def error_form
    bool = false
    DATA[:error_text].each_with_index do |x,i|
      bool = true if @browser.div(ELEMENT[:error]).text.include?(DATA[:error_text][i])
    end
    return bool
  end
end
