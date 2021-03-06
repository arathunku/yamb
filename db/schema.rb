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

ActiveRecord::Schema.define(version: 20130407131752) do

  create_table "designs", force: true do |t|
    t.integer  "user_id"
    t.text     "html"
    t.text     "css"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "designs", ["user_id"], name: "index_designs_on_user_id"

  create_table "posts", force: true do |t|
    t.integer  "user_id"
    t.text     "content",    limit: 4294967295
    t.text     "excerpt"
    t.string   "title"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "metadata"
  end

  add_index "posts", ["status"], name: "index_posts_on_status"
  add_index "posts", ["title"], name: "index_posts_on_title"

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "bio"
    t.string   "fullname"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
