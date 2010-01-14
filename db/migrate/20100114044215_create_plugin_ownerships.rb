class CreatePluginOwnerships < ActiveRecord::Migration
  def self.up
    create_table :plugin_ownerships do |t|
      t.integer :user_id
      t.integer :plugin_id

      t.timestamps
    end
  end

  def self.down
    drop_table :plugin_ownerships
  end
end
