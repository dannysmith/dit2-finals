class GroupPage < GenericPage
  def select_add_members
    @browser.input(id: "showaddmembersform").click
  end
end