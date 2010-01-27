require 'test_helper'

class DownloadTest < ActiveSupport::TestCase
  should "be a valid factory" do
    assert_valid Factory.build(:download)
  end

  should_belong_to :version
  should_validate_presence_of :version_id

  context "when there is a plugin" do
    context "on new download" do
      setup do
        @plugin = Factory(:plugin)
        @versions = Array(1..3).collect do |i|
          version = Factory(:version, :plugin => @plugin)
          i.times { Factory(:download, :version => version) }

          version
        end
        Factory(:download, :version => @versions.first)
      end

      should "update the plugin counter cache" do
        @plugin.reload
        assert_equal 7, @plugin.downloads_count
      end
    end
  end
end
