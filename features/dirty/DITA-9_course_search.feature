Feature: Course Search

  @DITA-9 @wip
  Scenario Outline: Should allow students to search for courses
    Given I am login as a student
    When I search for <course>
    Then I should see a list of results for this course

    Examples:
    | course |  
    | test   |  
