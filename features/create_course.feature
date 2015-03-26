Feature: Create Course
  As a teacher I want to be able to create a new course on the website, so that my students can enroll on them.

  Scenario: Successfully creating the course
    Given I am logged in as a teacher 
    When I create a new course with valid data
    Then I should be able to see it on my list of courses
    And it should be able to be seen by a student

  Scenario: Not allowing missing data
    Given I am logged in as a teacher
    When I try to create a new course without filling out all the required information
    Then it should not allow me to create the course
    And should inform me of what extra information is needed

  Scenario: Shouldn't allow students to create courses
    Given I am logged in as a student
    Then it should not be possible for me to create a new course
