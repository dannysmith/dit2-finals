Feature: 
  As a Teacher I want to be able to assign a user to a course so that he/she can perform teacher-related tasks on that course.

Scenario: Admin assign permission to teacher
  Given I'm signed in as an admin 
  And navigated to Define Roles under Users Permissions 
  When Allow Role Assignments tab is selected
  Then I should be able to allow a teacher to asign another teacher

Scenario: Teacher assigns a teacher to a course
  Given I'm signed in as a teacher to a course
  
