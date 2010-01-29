class PluginsController < ApplicationController
  include PluginsCommon

  before_filter :redirect_to_root, :unless => :signed_in?, :only => [:new, :create, :edit, :update]
  # rails won't allow you to have two before_filters with the same method name
  before_filter :find_plugin, :only => [:show, :edit, :update]

  def index
    @plugins = Plugin.find(:all, :order => "name ASC")
  end

  def new
    @plugin = Plugin.new
  end

  def create
    begin
      create_plugin

      redirect_to plugin_path(@plugin)
    rescue ActiveRecord::RecordInvalid, URI::InvalidURIError => e
      Rails.logger.info("Failed to create plugin: #{e.message}")
      render :new
    end
  end

  def show
    if @plugin
      @latest_version = @plugin.versions.by_date(:desc).limited(1).first
      @versions = @plugin.versions.by_date(:desc).limited(5)
    else
      render :no_plugin_found
    end
  end

  def edit
  end

  def update
    if @plugin.update_attributes(params[:plugin])
      flash[:success] = "Plugin updated."
      redirect_to plugin_path(@plugin)
    else
      render :edit
    end
  end

  private
  def find_plugin
    @plugin = Plugin.find_by_id(params[:id])
  end
end
