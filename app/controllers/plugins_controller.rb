class PluginsController < ApplicationController
  before_filter :redirect_to_root, :unless => :signed_in?

  def new
    @plugin = Plugin.new
  end

  def create
    @plugin = Plugin.new(params[:plugin])
    @plugin.save
    @plugin_ownership = @plugin.plugin_ownerships.create(:user => current_user)
    redirect_to plugin_path(@plugin)
  end

  def show
    @plugin = Plugin.find_by_id(params[:id])
  end
end
