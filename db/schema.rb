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

ActiveRecord::Schema.define(:version => 20120229163005) do

  create_table "albums", :primary_key => "album_id", :force => true do |t|
    t.string   "artist"
    t.integer  "year"
    t.integer  "item_id"
    t.datetime "date_created",     :default => '2012-02-29 18:48:26'
    t.boolean  "retired",          :default => false
    t.integer  "creator_id"
    t.datetime "retired_datetime"
  end

  create_table "item", :primary_key => "item_id", :force => true do |t|
    t.string   "item_type"
    t.text     "description"
    t.text     "image_url"
    t.datetime "date_created",     :default => '2012-02-29 18:36:20'
    t.boolean  "retired",          :default => false
    t.datetime "retired_datetime"
    t.string   "retired_reason"
  end

  create_table "item_type", :primary_key => "item_type_id", :force => true do |t|
    t.string   "name"
    t.datetime "date_created",     :default => '2012-02-29 18:36:19'
    t.boolean  "retired",          :default => false
    t.datetime "retired_datetime"
    t.string   "retired_reason"
  end

  create_table "people", :primary_key => "people_id", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birthdate"
    t.string   "gender"
    t.datetime "date_created",     :default => '2012-02-29 18:36:18'
    t.boolean  "retired",          :default => false
    t.datetime "retired_datetime"
    t.string   "retired_reason"
  end

  create_table "people_identifier", :primary_key => "people_identifier_id", :force => true do |t|
    t.string   "identifier"
    t.datetime "date_created",     :default => '2012-02-29 18:36:19'
    t.boolean  "retired",          :default => false
    t.datetime "retired_datetime"
    t.string   "retired_reason"
  end

  create_table "people_identifier_type", :primary_key => "people_identifier_type_id", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "date_created",     :default => '2012-02-29 18:36:20'
    t.boolean  "retired",          :default => false
    t.datetime "retired_datetime"
    t.string   "retired_reason"
  end

  create_table "relationships", :id => false, :force => true do |t|
    t.integer "parent"
    t.integer "child"
  end

  create_table "songs", :primary_key => "song_id", :force => true do |t|
    t.string   "title"
    t.string   "genre"
    t.integer  "year"
    t.integer  "item_id"
    t.datetime "date_created",     :default => '2012-02-29 18:48:26'
    t.boolean  "retired",          :default => false
    t.integer  "creator_id"
    t.datetime "retired_datetime"
  end

  create_table "users", :primary_key => "user_id", :force => true do |t|
    t.string   "username"
    t.string   "password"
    t.string   "salt"
    t.integer  "people_id"
    t.datetime "date_created",     :default => '2012-02-29 18:36:18'
    t.boolean  "retired",          :default => false
    t.integer  "creator_id"
    t.datetime "retired_datetime"
    t.string   "retired_reason"
  end

end
