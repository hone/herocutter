class ProfilesController < ApplicationController
  before_filter :find_user
  before_filter :redirect_to_root, :unless => :signed_in?

  def show
  end

  def reset_api_key
    @user.reset_api_key!
    redirect_to profile_path
  end

  private
  def find_user
    @user = current_user
  end
end
