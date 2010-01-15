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
    when /the new plugin page/
      new_plugin_path
    when /the plugin page for "([^\"]+)"/
      plugin = Plugin.find_by_name!($1)
      plugin_path(plugin)
    else
      raise "Can't find mapping from \"#{page_name}\" to a path."
    end
  end
end
 
World(NavigationHelpers)