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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160703155735) do

  create_table "resources", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "source",      null: false
    t.string   "current"
    t.string   "scheme_type", null: false
    t.string   "scheme"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "resources", ["name"], name: "index_resources_on_name"

  create_table "users", force: :cascade do |t|
    t.string   "slack_id",                           null: false
    t.text     "resources_ids", default: "--- []\n"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

end
