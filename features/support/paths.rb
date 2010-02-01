module NavigationHelpers
  def path_to(page_name)
    case page_name
    
    when /the homepage/i
      root_path
    when /the sign up page/i
      new_user_path
    when /the sign in page/i
      new_session_path
    when /the password reset request page/i
      new_password_path
    
    # Add more page name => path mappings here
    when /the plugins listing page/
      plugins_path
    when /the api plugins listing page/
      api_v1_plugins_path(:format => 'json')
    when /the new plugin page/
      new_plugin_path
    when /the plugin page for "([^\"]+)"/
      plugin = Plugin.find_by_name!($1)
      plugin_path(plugin)
    when /the api plugin page for "([^\"]+)"/
      api_v1_plugin_path($1, :format => 'json')
    when /the profile page/
      profile_path
    else
      raise "Can't find mapping from \"#{page_name}\" to a path."
    end
  end
end
 
World(NavigationHelpers)
