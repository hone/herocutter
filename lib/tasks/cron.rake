desc "Heroku Cron Task"
task :cron => :environment do
  Plugin.all.each do |plugin|
    plugin.fetch_latest_version
  end
end
