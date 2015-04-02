class GroupPage < GenericPage
  def select_create_group
    @browser.input(value: "Create group").click
  end
  def select_add_members
    @browser.input(id: "showaddmembersform").click
  end
end