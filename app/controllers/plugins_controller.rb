class PluginsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :if => :has_api_key?, :only => [:create]
  before_filter :redirect_to_root, :unless => :signed_in?, :only => [:new, :edit, :update]
  # rails won't allow you to have two before_filters with the same method name
  before_filter :redirect_to_root_for_create, :only => [:create]
  before_filter :find_plugin, :only => [:edit, :update]

  def index
    @plugins = Plugin.find(:all, :order => "name ASC")
  end

  def new
    @plugin = Plugin.new
  end

  def create
    begin
      @plugin = Plugin.new(params[:plugin])
      if @plugin.name.blank?
        @plugin.name = Plugin.parse_name(@plugin.uri)
      end

      ActiveRecord::Base.transaction do
        @plugin.save!
        @plugin_ownership = @plugin.plugin_ownerships.build(:user => @user)
        @plugin_ownership.save!
        @plugin.send_later(:fetch_latest_version)
      end

      respond_to do |format|
        format.html do
          redirect_to plugin_path(@plugin)
        end
        format.json do
          render :json => @plugin.to_json
        end
      end
    rescue ActiveRecord::RecordInvalid, URI::InvalidURIError => e
      Rails.logger.info("Failed to create plugin: #{e.message}")
      respond_to do |format|
        format.html do
          render :new
        end
        format.json do
          render :could_not_create_plugin
        end
      end
    end
  end

  def show
    find_plugin_by_name_or_id(params[:id])
    if @plugin
      respond_to do |format|
        format.html do
          @latest_version = @plugin.versions.by_date(:desc).limited(1).first
          @versions = @plugin.versions.by_date(:desc).limited(5)
        end
        format.json do
          render :json => @plugin.to_json
        end
      end
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

  def signed_in_or_has_api_key?
    user = has_api_key?
   if signed_in?
     @user = current_user
   elsif has_api_key?
     @user = User.find_by_api_key(params[:api_key])
   end
  end

  def has_api_key?
    User.find_by_api_key(params[:api_key])
  end

  def redirect_to_root_for_create
    if not signed_in_or_has_api_key? and not request.format.to_sym == :json
      redirect_to_root
    end
  end

  def find_plugin_by_name_or_id(id)
    @plugin = (Plugin.find_by_name(params[:id]) or Plugin.find_by_id(params[:id].to_i))
  end
end
