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

ActiveRecord::Schema.define(version: 20140513130608) do

  create_table "projects", force: true do |t|
    t.string   "github_path", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["github_path"], name: "index_projects_on_github_path", unique: true

  create_table "requests", force: true do |t|
    t.string   "title",           default: "", null: false
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",         default: 0,  null: false
    t.integer  "project_id",      default: 0,  null: false
    t.integer  "github_issue_id"
  end

  add_index "requests", ["project_id"], name: "index_requests_on_project_id"
  add_index "requests", ["user_id"], name: "index_requests_on_user_id"

  create_table "story_points", force: true do |t|
    t.text     "title"
    t.string   "user_github_login",      null: false
    t.string   "user_github_avatar_url"
    t.integer  "user_id"
    t.string   "story_point_size"
    t.datetime "github_closed_at"
    t.datetime "github_merged_at"
    t.string   "story_point_type"
    t.string   "github_html_url",        null: false
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "story_points", ["project_id"], name: "index_story_points_on_project_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.string   "name",                   default: "", null: false
    t.string   "skype"
    t.string   "vk"
    t.string   "twitter"
    t.string   "facebook"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
