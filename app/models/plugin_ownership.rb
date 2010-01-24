class PluginOwnership < ActiveRecord::Base
  belongs_to :user
  belongs_to :plugin

  validates_presence_of :user_id
  validates_presence_of :plugin_id
  validate :uniqueness_of_user_id_and_plugin_id

  private
  def uniqueness_of_user_id_and_plugin_id
    if PluginOwnership.exists?(:user_id   => self.user_id,
                               :plugin_id => self.plugin_id)
      errors.add_to_base("The user already owns that plugin")
    end
  end
end
