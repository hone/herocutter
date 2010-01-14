class PluginOwnership < ActiveRecord::Base
  belongs_to :user
  belongs_to :plugin

  validates_presence_of :user_id
  validates_presence_of :plugin_id
  validate :uniqueness_of_user_id_and_plugin_id

  private
  def uniqueness_of_user_id_and_plugin_id
    !PluginOwnership.find_by_user_id_and_plugin_id(self.user_id, self.plugin_id)
  end
end
