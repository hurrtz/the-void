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

ActiveRecord::Schema.define(version: 20140411081308) do

  create_table "planets", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "systems", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "nick",        limit: 512, null: false
    t.string   "onick",       limit: 500, null: false
    t.text     "password",    limit: 128, null: false
    t.string   "email",       limit: 512
    t.text     "activatekey", limit: 32,  null: false
    t.boolean  "active",                  null: false
    t.datetime "loginrecent"
    t.datetime "loginfirst"
    t.datetime "created"
  end

  add_index "users", ["active"], name: "index_users_on_active"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["nick"], name: "index_users_on_nick", unique: true
  add_index "users", ["onick"], name: "index_users_on_onick"
  add_index "users", ["password"], name: "index_users_on_password", unique: true

end
