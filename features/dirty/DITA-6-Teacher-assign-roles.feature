@DITA6_setup @DITA6_teardown @wip
Feature: Teacher assigning roles to users
  As a Teacher I want to be able to assign a user to a course so that he/she can perform teacher-related tasks on that course.

  Scenario: Enrol and assign teacher role to a user
    Given I am signed in as a teacher
    When I enrol Kate Johnson into the course as a teacher
    Then I should see Kate Johnson in the course as a teacher
  