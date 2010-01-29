class HomeController < ApplicationController
  def index
    @count = Plugin.count
    @latest     = Plugin.by_created_at(:desc).limited(5)
    @downloaded = Plugin.by_downloads_count(:desc).limited(5)
    @updated    = Version.recently_updated
  end
end
