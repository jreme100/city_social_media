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

ActiveRecord::Schema.define(:version => 20120719022916) do

  create_table "facebook_pages", :force => true do |t|
    t.integer  "municipality_id"
    t.integer  "facebook_id",         :limit => 8
    t.string   "url"
    t.string   "name"
    t.integer  "likes"
    t.integer  "checkins"
    t.integer  "were_here_count"
    t.integer  "talking_about_count"
    t.boolean  "can_post",                         :default => false
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
  end

  create_table "facebook_posts", :force => true do |t|
    t.integer  "facebook_page_id"
    t.integer  "on_id"
    t.integer  "likes"
    t.integer  "shares"
    t.string   "from"
    t.text     "body"
    t.datetime "fb_created_at"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "municipalities", :force => true do |t|
    t.string   "geographic_area"
    t.string   "state"
    t.string   "url"
    t.integer  "population_estimate"
    t.integer  "region"
    t.integer  "size"
    t.boolean  "facebook",               :default => false
    t.boolean  "twitter",                :default => false
    t.boolean  "multiple_accounts",      :default => false
    t.string   "multiple_account_notes"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "twitter_pages", :force => true do |t|
    t.integer  "municipality_id"
    t.integer  "twitter_id",      :limit => 8
    t.string   "url"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

end
