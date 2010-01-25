Factory.define(:version) do |version|
  version.name { Factory.next :name }
  version.date { Time.now }
  version.association(:plugin)
end
