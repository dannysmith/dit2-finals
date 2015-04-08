class CourseEnrolPage < GenericPage

  ELEMENT = {
    users: {text:'Users'},
    users_menu: {text: 'Enrolled users'},
    enrol_users_button: {value: 'Enrol users'},
    enrol_button: {class: 'enrol'},
    roles: {id:'id_enrol_manual_assignable_roles'},
    user_list: {class: 'user'},
    user_name: {class: 'fullname'}
  }

  def visit(id)
    @browser.goto EnvConfig.base_url + EnvConfig.course_enrol + id
  end

  def enrol_users_button
    @browser.button(ELEMENT[:enrol_users_button])
  end

  def enrol(firstname, lastname)
    @browser.divs(ELEMENT[:user_list]).each do |div|
      if div.div(ELEMENT[:user_name]).text == (firstname)+' '+(lastname)
        div.button(ELEMENT[:enrol_button]).click
        break
      end
    end
  end

  def finish_enroling_button
    @browser.button(value: "Finish enrolling users")
  end

  def check_role (fullname)
    role = ""
    @browser.trs(class: 'userinforow').each do |tr|
      if tr.div(class: 'subfield subfield_firstname').text == fullname
        role = tr.div(class: "role role_3").text
        break
      end
    end
    role
  end

  def assign_role (role)
    @browser.select_list(id:"id_enrol_manual_assignable_roles").select role
  end
end
