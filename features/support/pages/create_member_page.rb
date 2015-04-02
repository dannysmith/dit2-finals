class CreateMemberPage < GenericPage
  def add_members(user1, user2)
    @browser.option(text: /^#{user1}+/).select
    @browser.option(text: /^#{user2}+/).select
    submit
  end

  def submit
    @browser.input(id: "add").click
  end
end