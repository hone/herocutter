class User < ActiveRecord::Base
  include Clearance::User

  is_gravtastic!

  has_many :plugin_ownerships
  has_many :plugins, :through => :plugin_ownerships
end
