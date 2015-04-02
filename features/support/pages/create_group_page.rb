class ManageGroupPage < GenericPage
  def submit_group_name(group_name)
    @browser.input(id: "id_name").send_keys(group_name)
    submit
  end

  def submit
    @browser.input(id: "id_submitbutton").click
  end
end