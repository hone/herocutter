class HomeController < ApplicationController
  def index
    @latest     = []
    @downloaded = []
    @updated    = []
  end
end
