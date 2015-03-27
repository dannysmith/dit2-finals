Feature: Course Search

  @DITA-9
  Scenario: Should allow students to search for courses
    Given I am logged in as a student
    When I search for "test"
    Then I should see a list of result relevent to "test"
