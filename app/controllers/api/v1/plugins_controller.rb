class Api::V1::PluginsController < ApplicationController
  include PluginsCommon

  skip_before_filter :verify_authenticity_token, :only => [:create]
  before_filter :authenticate_with_api_key, :only => [:create]

  # install
  def show
    @plugin = Plugin.find_by_name(params[:id])
    if @plugin
      @latest_version = @plugin.versions.by_date(:desc).limited(1).first
      if @latest_version
        @latest_version.downloads.create
        @plugin.reload
      end

      render :json => @plugin.to_json
    else
      render :no_plugin_found
    end
  end

  # push
  def create
    begin
      create_plugin

      render :json => @plugin.to_json
    rescue ActiveRecord::RecordInvalid, URI::InvalidURIError => e
      Rails.logger.info("Failed to create plugin: #{e.message}")
      render :could_not_create_plugin
    end
  end
end
