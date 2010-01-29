require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  context "when not logged in" do
    context "and there are some plugins" do
      setup do
        @versions = []
        @plugins = Array(1..8).collect do |i|
          plugin = Factory(:plugin, :downloads_count => 8 - i)
          @versions << Factory(:version, :plugin => plugin)

          plugin
        end
      end

      context "on GET index" do
        setup do
          get :index
        end

        should_assign_to(:count) { 8 }
        should_assign_to(:latest) { @plugins[3, 5].reverse }
        should_assign_to(:downloaded) { @plugins[0, 5] }
        should_assign_to(:updated) { @versions[3, 5].reverse }
      end
    end
  end
end
