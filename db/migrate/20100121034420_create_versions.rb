class CreateVersions < ActiveRecord::Migration
  def self.up
    create_table :versions do |t|
      t.integer   :plugin_id
      t.string    :name
      t.timestamp :date

      t.timestamps
    end
  end

  def self.down
    drop_table :versions
  end
end
