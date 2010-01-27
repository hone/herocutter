require 'test_helper'

class VersionTest < ActiveSupport::TestCase
  should "be valid with a factory" do
    assert_valid Factory.build(:version)
  end

  should_belong_to :plugin
  should_have_many :downloads
  should_validate_presence_of :name, :plugin_id, :date

  context "with an existing version" do
    setup do
      @existing_version = Factory(:version)
    end

    context "and a unique name/plugin combination" do
      setup do
        @version = Factory(:version,
                           :name   => "unique name",
                           :plugin => @existing_version.plugin)
      end

      should_create :version
    end

    context "and the same name/plugin combination is used" do
      setup do
        Version.create(:name   => @existing_version.name,
                       :plugin => @existing_version.plugin)
      end

      should_not_change("Version count") { Version.count }
    end

    context "on abbreviated_name" do
      setup do
        @existing_version.update_attribute(:name, "c06086927ad88a5550e6d10fb81c65b5750e82b2")
      end

      should "be the first 7 characters" do
        assert_equal @existing_version.abbreviated_name, "c060869"
      end
    end

    context "with a new download" do
      setup do
        Factory(:download, :version => @existing_version)
        @existing_version.reload
      end

      should_change("downloads_count", :from => 0, :to => 1) { @existing_version.downloads_count }
    end
  end
end
