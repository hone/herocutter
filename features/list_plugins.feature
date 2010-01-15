Feature: List Plugins
  In order to install plugins
  A heroku gem user
  Should be able to look at all plugins

  Scenario: Guest looks at available plugins
    Given a plugin "plugin1" exists
    And a plugin "plugin2" exists
    And a plugin "plugin3" exists
    When I go to the homepage
    And I follow "all plugins"
    Then I should be on the plugins listing page
    And I should see "plugin1"
    And I should see "plugin2"
    And I should see "plugin3"
