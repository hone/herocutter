class Version < ActiveRecord::Base
  include Pacecar

  belongs_to :plugin
  has_many :downloads, :dependent => :destroy
  
  validates_presence_of :plugin_id
  validates_presence_of :name
  validates_presence_of :date
  validate :uniqueness_of_name_and_plugin_id

  # display first 7 hash chars like git does
  def abbreviated_name
    self.name[0,7]
  end

  private
  def uniqueness_of_name_and_plugin_id
    if Version.exists?(:name      => self.name,
                       :plugin_id => self.plugin_id)
      errors.add_to_base("This version already exists.")
    end
  end
end
