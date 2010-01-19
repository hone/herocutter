Feature: Edit Plugin
  In order to fix my plugin information
  A heroku plugin developer
  Should be able to edit a plugin they made

  Background:
    Given I am signed up and confirmed as "email@person.com/password"
    And I sign in as "email@person.com/password"
    And I have a plugin "old_plugin"
    When I go to the plugin page for "old_plugin"
    And I follow "Edit"

  Scenario: User edits an existing plugin
    When I fill in "Git URI" with "git://github.com/old_plugin.git"
    And I press "Update"
    Then I should be on the plugin page for "old_plugin"
    And I should see the link source "git://github.com/old_plugin.git"

  Scenario: User edits an existing plugin with invalid data
    When I fill in "Git URI" with ""
    And I press "Update"
    Then I should see "Uri can't be blank"
