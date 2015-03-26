Feature: Create Course
  As a teacher I want to be able to create a new course on the website, so that my students can enroll on them.
  
  @course_teardown
  Scenario: Successfully creating the course
    Given I am logged in as a teacher 
    When I create a new course with valid data
    And the course is approved by an administrator
    Then I should be able to see it on my list of courses

  Scenario: Not allowing missing data
    Given I am logged in as a teacher
    When I create a new course with invalid data, missing out required information
    Then it should not allow me to create the course
    And should inform me of what extra information is needed
