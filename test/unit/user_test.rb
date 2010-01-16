require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context "valid factory" do
    setup do
      @user = Factory.build(:user)
    end
    subject { @user }

    should_have_many :plugin_ownerships
    should_have_many :plugins

    context "on create" do
      setup do
        @user.save
      end

      context "the api key" do
        should "be set" do
          assert @user.api_key
        end

        should "be 32bit hexadecimal" do
          assert /^[a-f0-9]{32}$/.match(@user.api_key)
        end
      end
    end
  end
end
