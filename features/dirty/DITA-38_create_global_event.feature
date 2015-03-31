Feature: Create Global Event
  As an Event Co-ordinator, I want to create global events so that my students can sign up to attend them.

  @event_teardown
  Scenario: Successfully creating the global event
    Given I am logged in as admin
    When I am on the new event page
    And I set the type of event to Site
    And I fill in the event details correctly
    Then I should see the global event on the Calendar page

  Scenario: Entering incorrect global event details
    Given I am logged in as admin
    When I am on the new event page
    And I set the type of event to Site
    And I fill in the event details incorrectly
    Then I should be prompted with an error message
