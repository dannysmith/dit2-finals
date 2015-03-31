@slow
Feature: Register to course
As a student I want to be able to Register myself so I can enroll on courses
  
  @new_user_teardown
  Scenario: Register with correct details
  Given I am on the sign up page
  When I fill in the form correctly  
  Then I should receive an email to verify my account

  Scenario: Register with incorrect details
  Given I am on the sign up page
  When I fill in the form incorrectly  
  Then I should see error texts for each incorrect field
