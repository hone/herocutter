class AddCounterCaches < ActiveRecord::Migration
  def self.up
    add_column :versions, :downloads_count, :integer, :default => 0
    add_column :plugins,  :downloads_count, :integer, :default => 0
  end

  def self.down
    remove_column :plugins,  :downloads_count
    remove_column :versions, :downloads_count
  end
end
