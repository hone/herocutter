require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  context "when not logged in" do
    context "and there are two plugins" do
      setup do
        2.times { Factory(:plugin) }
      end

      context "on GET index" do
        setup do
          get :index
        end

        should_assign_to(:count) { 2 }
      end
    end
  end
end
