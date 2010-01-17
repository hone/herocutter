require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  context "when logged in" do
    setup do
      @user = Factory(:user)
      sign_in_as(@user)
    end

    context "on GET show" do
      setup do
        get :show
      end

      should_respond_with :success
      should_render_template :show
      should_assign_to(:user) { @user }
    end

    context "on PUT reset_api_key" do
      setup do
        put :reset_api_key
      end

      should_respond_with :redirect
      should_redirect_to('the profile page') { profile_path }
      should_assign_to(:user) { @user }
      should_change("the api key") { @user.api_key }
    end
  end

  context "when not logged in" do
    context "on GET show" do
      setup do
        get :show
      end

      should_respond_with :redirect
      should_redirect_to('the homepage') { root_url }
    end

    context "on PUT reset_api_key" do
      setup do
        put :reset_api_key
      end

      should_respond_with :redirect
      should_redirect_to('the homepage') { root_url }
    end
  end
end
