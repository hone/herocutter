Given /^I have a plugin "([^\"]+)"$/ do |name|
  plugin = Factory(:plugin, :name => name)
  PluginOwnership.create!(:plugin => plugin, :user => User.last)
end

Given /^a plugin "([^\"]+)" exists$/ do |name|
  plugin = Factory(:plugin, :name => name)
  PluginOwnership.create!(:plugin => plugin, :user => Factory(:email_confirmed_user))
end

Then /^I should see the link source "([^\"]+)"$/ do |uri|
  assert_select "a[href=#{uri}]"
end

Then /^I should see the json of "([^\"]+)"$/ do |name|
  plugin = Plugin.find_by_name!(name)
  assert_equal plugin.to_json, response.body
end
