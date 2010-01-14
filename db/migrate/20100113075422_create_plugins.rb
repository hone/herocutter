class CreatePlugins < ActiveRecord::Migration
  def self.up
    create_table :plugins do |t|
      t.string :name
      t.string :description
      t.string :uri

      t.timestamps
    end
  end

  def self.down
    drop_table :plugins
  end
end
