require 'test_helper'

class PluginTest < ActiveSupport::TestCase
  context "valid factory" do
    setup do
      @plugin = Factory.build(:plugin)
    end
    subject { @plugin }

    should_have_many :plugin_ownerships
    should_have_many :users

    should_validate_presence_of :name
    should_validate_presence_of :uri

    context "with an existing plugin" do
      setup do
        Factory(:plugin)
      end
      subject { @plugin }

      should_validate_uniqueness_of :name
      should_validate_uniqueness_of :uri
    end

    context "with a user" do
      setup do
        @plugin.save!
        @user = Factory(:user)
      end

      should "not be owned by the user if no PluginOwnership" do
        assert !@plugin.owned_by?(@user)
      end

      should "be owned by the user if there's a PluginOwnership" do
        PluginOwnership.create(:plugin => @plugin, :user => @user)
        assert @plugin.owned_by?(@user)
      end
    end
  end
end
