class Plugin < ActiveRecord::Base
  has_many :plugin_ownerships
  has_many :owners, :through => :plugin_ownerships, :source => :user

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :uri
  validates_uniqueness_of :uri
  validates_format_of :name, :with => /^[a-zA-Z1-9]([\w-]*[a-zA-Z1-9])?$/

  def owned_by?(user)
    if self.plugin_ownerships.find_by_user_id(user.id)
      true
    else
      false
    end
  end
end