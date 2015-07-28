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

ActiveRecord::Schema.define(version: 20150701073750) do

  create_table "fragfiles", force: :cascade do |t|
    t.string  "addr"
    t.string  "md5"
    t.string  "sha1"
    t.string  "server_name"
    t.integer "phys_id"
    t.integer "index"
  end

  create_table "physfiles", force: :cascade do |t|
    t.integer "frag_num"
    t.string  "sha1"
    t.string  "md5"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password"
    t.date     "register_date"
    t.integer  "root_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "authen_token"
    t.integer  "wrong_token_time"
  end

  create_table "virfiles", force: :cascade do |t|
    t.integer "fa"
    t.string  "name"
    t.string  "path"
    t.integer "phys_id"
    t.boolean "visible"
    t.date    "update_time"
  end

end
