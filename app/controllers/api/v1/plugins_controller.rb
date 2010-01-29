class Api::V1::PluginsController < ApplicationController
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
end
