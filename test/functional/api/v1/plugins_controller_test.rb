require 'test_helper'

class Api::V1::PluginsControllerTest < ActionController::TestCase
  context "when not using an API Key" do
    context "and the plugin exists" do
      setup do
        @plugin = Factory(:plugin)
      end

      context "and there's a latest version" do
        setup do
          @versions = Array(1..5).collect { Factory(:version, :plugin => @plugin) }
          @version = Factory(:version, :plugin => @plugin)
          @versions << @version
        end

        context "on GET show by name" do
          setup do
            get :show, :id => @plugin.name
          end

          should_respond_with :success
          should_assign_to(:plugin) { @plugin }
          should_assign_to(:latest_version) { @version }
          should_respond_with_content_type :json
          should_create :download
          should "render json" do
            @plugin.reload
            assert_equal @plugin.to_json, @response.body
          end
        end
      end

      context "and there isn't a latest version" do
        context "on GET show by name" do
          setup do
            get :show, :id => @plugin.name, :format => "json"
          end

          should_respond_with :success
          should_assign_to(:plugin) { @plugin }
          should_not_assign_to(:latest_version)
          should_respond_with_content_type :json
          should_not_change("Download count") { Download.count }
          should "render json" do
            assert_equal @plugin.to_json, @response.body
          end
        end
      end
    end

    context "and the plugin does not exist" do
      context "on GET show" do
        setup do
          get :show, :id => "foo", :format => "json"
        end

        should_respond_with :success
        should_not_assign_to(:plugin)
        should_not_assign_to(:latest_version)
        should_respond_with_content_type :json
        should_not_change("Download count") { Download.count }
        should_render_template :no_plugin
      end
    end
  end
end
