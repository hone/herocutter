Feature: Add Plugin
  In order to share plugins
  A heroku plugin developer
  Should be able to add plugins from the website

  Background:
    Given I am signed up and confirmed as "email@person.com/password"
    When I sign in as "email@person.com/password"
    And I follow "new plugin"

  Scenario: User adds a plugin
    When I fill in "Name" with "new_plugin"
    And I fill in "Git URI" with "git://github.com/person/new_plugin.git"
    And I press "Cut"
    Then I should be on the plugin page for "new_plugin"
    And I should see "new_plugin"
    And I should see "heroku plugins:install new_plugin"
    And I should see "email@person.com"

  Scenario: User tries to add a plugin with invalid data
    When I fill in "Name" with "New Plugin"
    And I fill in "Git URI" with "git://github.com/person/new_plugin.git"
    And I press "Cut"
    Then I should see "is invalid"
