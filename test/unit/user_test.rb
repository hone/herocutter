require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context "valid factory" do
    setup do
      @user = Factory.build(:user)
    end
    subject { @user }

    should_have_many :plugin_ownerships
    should_have_many :plugins
  end
end
