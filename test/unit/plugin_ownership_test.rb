require 'test_helper'

class PluginOwnershipTest < ActiveSupport::TestCase
  context "valid factory" do
    setup { @plugin_ownership = PluginOwnership.new }
    subject { @plugin_ownership }

    should_belong_to :user
    should_belong_to :plugin

    should_validate_presence_of :user_id
    should_validate_presence_of :plugin_id
  end

  context "when PluginOwnership with plugin_id, user_id exists" do
    setup do
      @plugin = Factory(:plugin)
      @user = Factory(:email_confirmed_user)
      PluginOwnership.create(:plugin => @plugin, :user => @user)
    end

    context "on duplication of user_id, plugin_id" do
      setup do
        PluginOwnership.create(:plugin => @plugin, :user => @user)
      end

      should_not_change("PluginOwnership count") { PluginOwnership.count }
    end

    context "on duplication of only user_id" do
      setup do
        PluginOwnership.create(:plugin => Factory(:plugin), :user => @user)
      end

      should_create :plugin_ownership
    end

    context "on duplication of only plugin_id" do
      setup do
        PluginOwnership.create(:plugin => @plugin, :user => Factory(:user))
      end

      should_create :plugin_ownership
    end
  end
end
