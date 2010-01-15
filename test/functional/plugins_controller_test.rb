require 'test_helper'

class PluginsControllerTest < ActionController::TestCase
  context "when logged in" do
    setup do
      @user = Factory(:email_confirmed_user)
      sign_in_as(@user)
    end

    context "on GET new" do
      setup do
        get :new
      end
      
      should_respond_with :success
      should_render_template :new
      should_assign_to :plugin, :class => Plugin
    end

    context "on POST create" do
      setup do
        @plugin_params = {:name => "new_plugin", :uri => "git://github.com/justinfrench/formtastic.git" }
      end

      context "with valid data" do
        setup do
          post :create, :plugin => @plugin_params
        end

        should_create :plugin
        should_create :plugin_ownership
        should_respond_with :redirect
        should_redirect_to('the show plugin page') { plugin_path(assigns(:plugin)) }

        should "have the logged in user own the plugin" do
          assert_equal @user, assigns(:plugin_ownership).user
        end
      end

      context "with problems" do

        context "with plugin data" do
          setup do
            stub.instance_of(Plugin).save! { raise ActiveRecord::RecordInvalid.new(Plugin.new) }
            post :create, :plugin => @plugin_params
          end

          should_respond_with :success
          should_render_template :new
          should_assign_to :plugin, :class => Plugin
          should_not_change("Plugin count") { Plugin.count }
          should_not_change("PluginOwnership count") { PluginOwnership.count }
        end

        context "with PluginOwnership" do
          setup do
            stub.instance_of(PluginOwnership).save! { raise ActiveRecord::RecordInvalid.new(PluginOwnership.new) }
            post :create, :plugin => @plugin_params
          end

          should_respond_with :success
          should_render_template :new
          should_assign_to :plugin, :class => Plugin
          should_assign_to :plugin_ownership, :class => PluginOwnership
          should_not_change("Plugin count") { Plugin.count }
          should_not_change("PluginOwnership count") { PluginOwnership.count }
        end
      end
    end

    context "on GET show" do
      setup do
        @plugin = Factory(:plugin)
        get :show, :id => @plugin.id
      end

      should_respond_with :success
      should_render_template :show
      should_assign_to(:plugin) { @plugin }
    end

  end

  context "without being logged in" do
    context "on GET new" do
      setup do
        get :new
      end

      should_respond_with :redirect
      should_redirect_to('the hompage') { root_url }
    end

    context "on POST create" do
      setup do
        post :create
      end

      should_respond_with :redirect
      should_redirect_to('the hompage') { root_url }
    end

    context "on GET show" do
      setup do
        @plugin = Factory(:plugin)
        get :show, :id => @plugin.id
      end

      should_respond_with :redirect
      should_redirect_to('the homepage') { root_url }
    end
  end
end
