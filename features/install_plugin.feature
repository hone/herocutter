Feature: Install Plugin
  In order to enhance my heroku gem
  As a heroku customer
  Should be able to fetch plugin information for the gem

  Scenario: User should be able to get plugin information using plugin name
    Given a plugin "new_plugin" exists
    When I go to the plugin page by name for "new_plugin"
    Then I should see the json of "new_plugin"
