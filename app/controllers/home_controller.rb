class HomeController < ApplicationController
  def index
    @count = Plugin.count
    @latest     = []
    @downloaded = []
    @updated    = []
  end
end
