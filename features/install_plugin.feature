Feature: Install Plugin
  In order to enhance my heroku gem
  As a heroku customer
  Should be able to fetch plugin information for the gem

  Scenario: User should be able to get plugin information using plugin name
    Given a plugin "new_plugin" exists
    When I go to the plugin page by name for "new_plugin"
    Then I should see the json of "new_plugin"

  Scenario: User should be able to share their plugin online
    Given I am signed up and confirmed as "email@person.com/password"
    When I push plugin with git uri "git://github.com/new_plugin.git"
    And I sign in as "email@person.com/password"
    And I follow "all plugins"
    And I follow "new_plugin"
    Then I should be on the plugin page for "new_plugin"
    And I should see the link source "git://github.com/new_plugin.git"
