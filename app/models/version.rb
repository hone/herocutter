class Version < ActiveRecord::Base
  belongs_to :plugin
  
  validates_presence_of :plugin_id
  validates_presence_of :name
  validates_presence_of :date
  validate :uniqueness_of_name_and_plugin_id

  private
  def uniqueness_of_name_and_plugin_id
    if Version.exists?(:name      => self.name,
                       :plugin_id => self.plugin_id)
      errors.add_to_base("This version already exists.")
    end
  end
end
