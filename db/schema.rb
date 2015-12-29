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

ActiveRecord::Schema.define(version: 20151228000955) do

  create_table "chapters", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "state_id",   limit: 4
  end

  add_index "chapters", ["state_id"], name: "index_chapters_on_state_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "title",         limit: 255
    t.string   "sub_title",     limit: 255
    t.text     "body",          limit: 65535
    t.integer  "pageable_id",   limit: 4
    t.string   "pageable_type", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "pages", ["pageable_type", "pageable_id"], name: "index_pages_on_pageable_type_and_pageable_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "name",                 limit: 255
    t.string   "abbreviated_name",     limit: 255
    t.string   "census_division_name", limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "states", ["name"], name: "index_states_on_name", unique: true, using: :btree

  add_foreign_key "chapters", "states"
end
