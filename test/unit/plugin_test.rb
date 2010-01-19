require 'test_helper'

class PluginTest < ActiveSupport::TestCase
  context "valid factory" do
    setup do
      @plugin = Factory.build(:plugin)
    end
    subject { @plugin }

    should_have_many :plugin_ownerships
    should_have_many :owners, :through => :plugin_ownerships

    should_validate_presence_of :name
    should_validate_presence_of :uri
    should_not_allow_values_for :name, "New Plugin", "-newplugin", "_newplugin", "newplugin-", "newplugin_", "1", "1newplugin"
    should_allow_values_for :name, "new_plugin", "new-plugin", "newplugin", "newplugin", "newplugin1"

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

      should "can not be owned by nil" do
        assert !@plugin.owned_by?(nil)
      end
    end
  end

  context "class methods" do
    context "such as parse_name" do
      context "when given the uri with the name following the host" do
        setup do
          @uri = "git://github.com/new_plugin.git"
        end

        should "return the name" do
          assert_equal 'new_plugin', Plugin.parse_name(@uri)
        end
      end

      context "when given the uri with the name separated from the hsot" do
        setup do
          @uri = "git://github.com/hone/new_plugin.git"
        end

        should "return the name" do
          assert_equal "new_plugin", Plugin.parse_name(@uri)
        end
      end

      context "when given a blank uri" do
        setup do
          @uri = ""
        end

        should "return nil" do
          assert Plugin.parse_name(@uri).nil?
        end
      end
    end
  end
end
