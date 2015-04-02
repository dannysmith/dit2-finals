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
    @browser.goto 'http://unix.spartaglobal.com/moodle/enrol/users.php?id=' + id
  end

  def enrol_users_button
    @browser.button(ELEMENT[:enrol_users_button])
  end

  def enrol(firstname, lastname)
    raise "Enrol users list is not visible" unless @browser.divs(ELEMENT[:user_list]).visible?
    @browser.divs(ELEMENT[:user_list]).each do |div|
      if div.div(ELEMENT[:user_name]).text == (firstname)+' '+(lastname)
        div.button(ELEMENT[:enrol_button]).click
        break
      end
    end
  end

  def finish_enroling
    @browser.button(value: "Finish enrolling users")
  end

  def check_role (fullname)
    @browser.trs(class: 'userinforow').each do |tr|
      if tr.div(class: 'subfield subfield_firstname').text == (FIRSTNAME2)+' '+(LASTNAME2)
        expect(tr.div(class: "role role_3").text).to eq('Teacher')
        break
      end
    end
  end
end
