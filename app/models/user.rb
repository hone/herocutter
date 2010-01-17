class User < ActiveRecord::Base
  include Clearance::User
  before_create :generate_api_key

  is_gravtastic!

  has_many :plugin_ownerships
  has_many :plugins, :through => :plugin_ownerships

  def reset_api_key!
    generate_api_key and save!
  end

  private
  def generate_api_key
    self.api_key = ActiveSupport::SecureRandom.hex(16)
  end
end
