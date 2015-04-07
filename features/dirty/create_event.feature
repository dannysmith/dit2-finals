@user_register_enrollment
Feature: Event Calendar
  As an Event Co-ordinator, I want to create events so that my students can sign up to attend them.

  @event_teardown @DITA-38
  Scenario: Successfully creating the global event
    Given I am logged in as admin
    When I am on the new event page
    And I set the type of event to Site
    And I fill in the event details correctly
    Then I should see the global event on the Calendar page

  @DITA-38
  Scenario: Entering incorrect global event details
    Given I am logged in as admin
    When I am on the new event page
    And I set the type of event to Site
    And I fill in the event details incorrectly
    Then I should be prompted with an error message

  @DITA-39
  Scenario: Successfully creating the user event
    Given I am logged in as user
    When I am on the new event page
    And I set the type of event to User
    And I fill in the event details correctly
    Then I should see the user event on the Calendar page

  @DITA-39
  Scenario: Entering incorrect user event details
    Given I am logged in as user
    When I am on the new event page
    And I set the type of event to User
    And I fill in the event details incorrectly
    Then I should be prompted with an error message

  @DITA-40
  Scenario: Successfully creating the group event
    Given I am logged in as user
    And a group exists
    When I am on the course event page
    And I set the type of event to Group
    And I fill in the event details correctly
    Then I should see the group event on the Calendar page

  @DITA-40
  Scenario: Entering incorrect group event details
    Given I am logged in as user
    When I am on the course event page
    And I set the type of event to Group
    And I fill in the event details incorrectly
    Then I should be prompted with an error message

  @DITA-41 @wip
  Scenario: Successfully creating the course event
    Given I am logged in as user
    When I am on the course event page
    And I set the type of event to Course
    And I fill in the event details correctly
    Then I should see the course event on the Calendar page

  @DITA-41 @wip
  Scenario: Entering incorrect course event details
    Given I am logged in as user
    When I am on the course event page
    And I set the type of event to Course
    And I fill in the event details incorrectly
    Then I should be prompted with an error message