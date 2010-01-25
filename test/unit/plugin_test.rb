require 'test_helper'

class PluginTest < ActiveSupport::TestCase
  should "be valid with a factory" do
    assert_valid Factory.build(:plugin)
  end

  should_have_many :plugin_ownerships
  should_have_many :owners, :through => :plugin_ownerships
  should_have_many :versions

  should_validate_presence_of :name, :uri
  should_not_allow_values_for :name, "New Plugin", "-newplugin", "_newplugin", "newplugin-", "newplugin_", "1", "1newplugin"
  should_allow_values_for :name, "new_plugin", "new-plugin", "newplugin", "newplugin1", "newplugin0"

  context "with an existing plugin" do
    setup do
      Factory(:plugin)
    end

    should_validate_uniqueness_of :name
    should_validate_uniqueness_of :uri
  end

  context "with a user" do
    setup do
      @plugin = Factory(:plugin)
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

    context "when cloning a git repo" do
      setup do
        @sha = "c06086927ad88a5550e6d10fb81c65b5750e82b2"
        mock(@git_object = Object.new)
        mock(@head_object = Object.new)
        mock(@dir_object = Object.new)

        stub(Git).clone(@plugin.uri, @plugin.name, anything) { @git_object }
        stub(@git_object).object("HEAD") { @head_object }
        stub(@git_object).dir { @dir_object }
        stub(@dir_object).path { "#{RAILS_ROOT}/tmp/#{@plugin.name}" }
        stub(@head_object).sha { @sha }
        stub(@head_object).date { Time.now }
      end

      context "when there is no new version" do
        setup do
          Factory(:version, :plugin => @plugin, :name => @sha)
        end

        context "on fetch_latest_version" do
          setup do
            @plugin.fetch_latest_version
          end

          should_not_change("Version count") { Version.count }
          before_should "clean up git clone directory when done" do
            mock(FileUtils).rm_rf("#{RAILS_ROOT}/tmp/#{@plugin.name}")
          end
        end
      end

      context "when there is a new version" do
        context "on fetch_latest_version" do
          setup do
            @plugin.fetch_latest_version
          end

          should_create :version
          before_should "clean up git clone directory when done" do
            mock(FileUtils).rm_rf("#{RAILS_ROOT}/tmp/#{@plugin.name}")
          end
        end
      end

      context "when the git uri does not exist" do
        setup do
          stub(Git).clone(@plugin.uri, @plugin.name, anything) { raise Git::GitExecuteError }
        end

        context "on fetch_latest_version" do
          setup do
            @plugin.fetch_latest_version
          end

          should_not_change("Version count") { Version.count }
        end
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
