Feature: Install Plugin
  In order to enhance my heroku gem
  As a heroku customer
  Should be able to fetch plugin information for the gem

  Scenario: User should be able to get plugin information using plugin name
    Given a plugin git repo exists
    And a plugin "new_plugin" exists with the latest version
    When I go to the api plugin page for "new_plugin"
    Then I should see the json of "new_plugin"
    When I go to the plugin page for "new_plugin"
    Then I should see "1 total downloads"
    And I should see "1 for this version"
    When I follow "all plugins"
    Then I should see /1\s*downloads/

  Scenario: User should be able to share their plugin online
    Given I am signed up and confirmed as "email@person.com/password"
    When I push plugin with git uri "git://github.com/new_plugin.git"
    And I sign in as "email@person.com/password"
    And I follow "all plugins"
    And I follow "new_plugin"
    Then I should be on the plugin page for "new_plugin"
    And I should see the link source "git://github.com/new_plugin.git"

  Scenario: User should be able to see a list of plugins
    Given a plugin "new_plugin" exists
    And a plugin "second_plugin" exists
    When I go to the api plugins listing page
    Then I should see "new_plugin"
    And I should see "second_plugin"
