require 'test_helper'

class VersionTest < ActiveSupport::TestCase
  should "be valid with a factory" do
    assert_valid Factory.build(:version)
  end

  should_belong_to :plugin
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
  end
end
