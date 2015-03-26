Feature: Course Search
  As a student on the site I want to be able to search through the courses titles and descriptions to return a list of the courses matching the search term.

  Scenario: Should show relavent courses to the search term
    Given I am logged in as a student,
    When I enter 'Biology' as a course search term
    Then courses relating to Biology should be shown
