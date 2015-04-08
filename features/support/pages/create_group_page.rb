class CreateGroupPage < GenericPage
  def visit(course_id)
    @browser.goto EnvConfig.base_url + EnvConfig.create_group_url + course_id
  end

  def submit_form(group_name)
    @browser.input(id: "id_name").send_keys(group_name)
    submit
  end

  def submit
    @browser.input(id: "id_submitbutton").click
  end
end