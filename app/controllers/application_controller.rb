# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Clearance::Authentication
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  def authenticate_with_api_key
    api_key = request.headers["Authorization"] || params[:api_key]
    self.current_user = User.find_by_api_key(api_key)
  end
end

module PluginsCommon
  def list_plugins
    @plugins = Plugin.find(:all, :order => "name ASC")
  end

  # common code for create plugin
  def create_plugin
    @plugin = Plugin.new(params[:plugin])
    if @plugin.name.blank?
      @plugin.name = Plugin.parse_name(@plugin.uri)
    end
    if /^heroku_/.match(@plugin.name)
      @plugin.name.sub!(/^heroku_/, '')
    end

    ActiveRecord::Base.transaction do
      @plugin.save!
      @plugin_ownership = @plugin.plugin_ownerships.build(:user => current_user)
      @plugin_ownership.save!
      @plugin.send_later(:fetch_latest_version)
    end
  end
end
