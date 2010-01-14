Feature: Add Plugin
  In order to share plugins
  A heroku plugin developer
  Should be able to add plugins from the website

  Scenario: User adds a plugin
    Given I am signed up and confirmed as "email@person.com/password"
    When I sign in as "email@person.com/password"
    And I follow "new plugin"
    And I fill in "Name" with "new_plugin"
    And I fill in "URI" with "git://github.com/person/new_plugin.git"
    And I press "Cut"
    Then I should be on the plugin page for "new_plugin"
    And I should see "new_plugin"
    And I should see "heroku plugins:install new_plugin"
    And I should see "email@person.com"
