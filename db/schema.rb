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

ActiveRecord::Schema.define(:version => 20120226125941) do

  create_table "item", :force => true do |t|
    t.string   "item"
    t.text     "description"
    t.text     "image_url"
    t.datetime "date_created",     :default => '2012-02-26 14:57:45'
    t.boolean  "retired",          :default => false
    t.datetime "retired_datetime"
    t.string   "retired_reason"
  end

  create_table "item_type", :force => true do |t|
    t.string   "name"
    t.datetime "date_created",     :default => '2012-02-26 14:57:45'
    t.boolean  "retired",          :default => false
    t.datetime "retired_datetime"
    t.string   "retired_reason"
  end

  create_table "people", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birthdate"
    t.string   "gender"
    t.datetime "date_created",     :default => '2012-02-26 14:57:44'
    t.boolean  "retired",          :default => false
    t.datetime "retired_datetime"
    t.string   "retired_reason"
  end

  create_table "people_identifier", :force => true do |t|
    t.string   "identifier"
    t.datetime "date_created",     :default => '2012-02-26 15:03:19'
    t.boolean  "retired",          :default => false
    t.datetime "retired_datetime"
    t.string   "retired_reason"
  end

  create_table "people_identifier_type", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "date_created",     :default => '2012-02-26 15:03:19'
    t.boolean  "retired",          :default => false
    t.datetime "retired_datetime"
    t.string   "retired_reason"
  end

  create_table "relationships", :force => true do |t|
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password"
    t.datetime "date_created",     :default => '2012-02-26 14:57:44'
    t.boolean  "retired",          :default => false
    t.datetime "retired_datetime"
    t.string   "retired_reason"
  end

end
