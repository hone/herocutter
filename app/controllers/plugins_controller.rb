class PluginsController < ApplicationController
  before_filter :redirect_to_root, :unless => :signed_in?, :except => [:index, :show]
  before_filter :find_plugin, :only => [:edit, :update]

  def index
    @plugins = Plugin.find(:all, :order => "name ASC")
  end

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
      render :new
    end
  end

  def show
    find_plugin_by_name_or_id(params[:id])
    if @plugin
      respond_to do |format|
        format.html
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

  def find_plugin_by_name_or_id(id)
    @plugin = (Plugin.find_by_name(params[:id]) or Plugin.find_by_id(params[:id].to_i))
  end
end
