class Download < ActiveRecord::Base
  belongs_to :version, :counter_cache => true

  validates_presence_of :version_id

  after_create :increment_plugin_counter_cache

  private
  def increment_plugin_counter_cache
    Plugin.increment_counter(:downloads_count, self.version.plugin.id)
  end
end
