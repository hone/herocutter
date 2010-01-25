# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100121034420) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.string   "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["locked_by"], :name => "index_delayed_jobs_on_locked_by"

  create_table "plugin_ownerships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "plugin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plugins", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "uri"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "handle"
    t.string   "email"
    t.string   "encrypted_password", :limit => 128
    t.string   "salt",               :limit => 128
    t.string   "confirmation_token", :limit => 128
    t.string   "remember_token",     :limit => 128
    t.boolean  "email_confirmed",                   :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "api_key"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["handle"], :name => "index_users_on_handle"
  add_index "users", ["id", "confirmation_token"], :name => "index_users_on_id_and_confirmation_token"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "versions", :force => true do |t|
    t.integer  "plugin_id"
    t.string   "name"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
