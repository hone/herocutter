Feature: API Key
  In order to share plugins with the world
  As a heroku plugin developer
  Should be able to find it and reset it

  Scenario: User finds API key
    Given I have signed in with "email@person.com/password"
    And I go to the homepage
    When I follow "email@person.com"
    Then I should be on the profile page
    And I should see my "API key"

  Scenario: User compromises API key and wants to reset it
    Given I have signed in with "email@person.com/password"
    And I go to the homepage
    When I follow "email@person.com"
    Then I should be on the profile page
    When I press "Reset my API key"
    Then I should see my new "API key"
