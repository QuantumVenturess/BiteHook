# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121010191530) do

  create_table "attendances", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attendances", ["user_id", "event_id"], :name => "index_attendances_on_user_id_and_event_id", :unique => true

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["content"], :name => "index_comments_on_content"
  add_index "comments", ["user_id", "event_id"], :name => "index_comments_on_user_id_and_event_id"

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "date"
    t.text     "info"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.integer  "zip_code"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image1"
    t.string   "image2"
    t.string   "image3"
    t.float    "price"
  end

  add_index "events", ["address_1"], :name => "index_events_on_address_1"
  add_index "events", ["address_2"], :name => "index_events_on_address_2"
  add_index "events", ["city"], :name => "index_events_on_city"
  add_index "events", ["date"], :name => "index_events_on_date"
  add_index "events", ["info"], :name => "index_events_on_info"
  add_index "events", ["name"], :name => "index_events_on_name"
  add_index "events", ["price"], :name => "index_events_on_price"
  add_index "events", ["slug"], :name => "index_events_on_slug"
  add_index "events", ["state"], :name => "index_events_on_state"
  add_index "events", ["zip_code"], :name => "index_events_on_zip_code"

  create_table "payments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.float    "amount"
    t.string   "transaction_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["amount"], :name => "index_payments_on_amount"
  add_index "payments", ["description"], :name => "index_payments_on_description"
  add_index "payments", ["transaction_id"], :name => "index_payments_on_transaction_id"
  add_index "payments", ["user_id", "event_id"], :name => "index_payments_on_user_id_and_event_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "image"
    t.string   "location"
    t.integer  "facebook_id"
    t.string   "access_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",        :default => false
    t.string   "slug"
    t.datetime "last_in"
    t.integer  "in_count"
  end

  add_index "users", ["access_token"], :name => "index_users_on_access_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["facebook_id"], :name => "index_users_on_facebook_id", :unique => true
  add_index "users", ["first_name"], :name => "index_users_on_first_name"
  add_index "users", ["in_count"], :name => "index_users_on_in_count"
  add_index "users", ["last_in"], :name => "index_users_on_last_in"
  add_index "users", ["last_name"], :name => "index_users_on_last_name"
  add_index "users", ["location"], :name => "index_users_on_location"
  add_index "users", ["name"], :name => "index_users_on_name"
  add_index "users", ["slug"], :name => "index_users_on_slug"

end
