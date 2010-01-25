Given /^a plugin git repo exists$/ do
  @git_repo = File.dirname(__FILE__) + "/../../tmp/sandbox"
  readme = @git_repo + "/README"
  FileUtils.rm_r(@git_repo, :force => true)
  FileUtils.mkdir(@git_repo)
  FileUtils.touch(readme)
  g = Git.init(@git_repo)
  g.add(readme)
  g.commit("initial commit")
  @latest_hash = g.object('HEAD').sha
end

Then /^I should see the latest version$/ do
  Then %{I should see "#{@latest_hash[0..6]}"}
end
