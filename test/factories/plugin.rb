Factory.define(:plugin) do |plugin|
  plugin.name { Factory.next :name }
  plugin.uri  { "git@github.com:#{Factory.next :name}.git" }
end
