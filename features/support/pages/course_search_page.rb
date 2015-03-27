class CourseSearchPage < GenericPage
  def visit(search_term)
    @browser.goto EnvConfig.course_search_url+"?search=#{search_term}"
  end

  def check_results(search_term)
    @browser.h3s(class: "coursename").each do |h3_index|
      raise "relevent results not found" unless h3_index.text.downcase.include?(search_term.downcase)
    end
  end

end
