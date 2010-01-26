class Plugin < ActiveRecord::Base
  include Pacecar

  has_many :plugin_ownerships
  has_many :owners, :through => :plugin_ownerships, :source => :user
  has_many :versions

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :uri
  validates_uniqueness_of :uri
  validates_format_of :name, :with => /^[a-zA-Z]([\w-]*[a-zA-Z0-9])?$/

  def owned_by?(user)
    if self.plugin_ownerships.find_by_user_id(user.try(:id))
      true
    else
      false
    end
  end

  def self.parse_name(uri)
    uri = URI.parse(uri)
    uri.try(:path).try(:split, '/').try(:last).try(:split, '.').try(:first)
  end

  def fetch_latest_version
    begin
      g = Git.clone(self.uri, self.name, :path => "#{RAILS_ROOT}/tmp/")
      head = g.object("HEAD")
      version_name = head.sha
      version_date = head.date
      self.versions.create(:name => version_name, :date => version_date)
      FileUtils.rm_rf(g.dir.path)
    rescue Git::GitExecuteError
      Rails.logger.info("ERROR fetching: could not fetch plugin: #{self.name}")
      nil
    end

  end
end
