class User < ActiveRecord::Base
  include Clearance::User
  before_create :generate_api_key

  is_gravtastic!

  has_many :plugin_ownerships
  has_many :plugins, :through => :plugin_ownerships

  private
  def generate_api_key
    self.api_key = ActiveSupport::SecureRandom.hex(16)
  end
end
