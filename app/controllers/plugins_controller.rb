class PluginsController < ApplicationController
  before_filter :redirect_to_root, :unless => :signed_in?

  def new
    @plugin = Plugin.new
  end

  def create
    @plugin = Plugin.new(params[:plugin])

    begin
      ActiveRecord::Base.transaction do
        @plugin.save!
        @plugin_ownership = @plugin.plugin_ownerships.build(:user => current_user)
        @plugin_ownership.save!
      end

      redirect_to plugin_path(@plugin)
    rescue ActiveRecord::RecordInvalid => e
      render :action => :new
    end
  end

  def show
    @plugin = Plugin.find_by_id(params[:id])
  end
end
