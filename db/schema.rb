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

ActiveRecord::Schema.define(version: 20160527204020) do

  create_table "commisaries", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "birth_number",           limit: 255
    t.string   "address",                limit: 255
    t.string   "postal_address",         limit: 255
    t.string   "phone",                  limit: 255
    t.string   "email",                  limit: 255
    t.integer  "town_hall_id",           limit: 4
    t.string   "ward_number",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ward_id",                limit: 4
    t.string   "encrypted_password",     limit: 255
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",          limit: 4
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.integer  "user_id",                limit: 4
  end

  create_table "districts", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.integer  "municipality_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: :cascade do |t|
    t.string   "uuid",           limit: 255
    t.string   "name",           limit: 255
    t.string   "requestor_type", limit: 255
    t.integer  "requestor_id",   limit: 4
    t.string   "eventable_type", limit: 255
    t.integer  "eventable_id",   limit: 4
    t.string   "command",        limit: 255
    t.text     "metadata",       limit: 65535
    t.text     "data",           limit: 65535
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "municipalities", force: :cascade do |t|
    t.string   "name",                 limit: 255
    t.integer  "region_id",            limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "registration_allowed"
  end

  create_table "rails_admin_histories", force: :cascade do |t|
    t.text     "message",    limit: 65535
    t.string   "username",   limit: 255
    t.integer  "item",       limit: 4
    t.string   "table",      limit: 255
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree

  create_table "regions", force: :cascade do |t|
    t.string   "name",                 limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password",             limit: 255
    t.string   "chairman_email",       limit: 255
    t.string   "assignee_name",        limit: 255
    t.datetime "registration_ends_at"
    t.integer  "representative_id",    limit: 4
  end

  create_table "town_halls", force: :cascade do |t|
    t.string   "type",            limit: 255
    t.string   "name",            limit: 255
    t.string   "address",         limit: 255
    t.integer  "wards_count",     limit: 4
    t.string   "wards_list_uri",  limit: 255
    t.integer  "municipality_id", limit: 4
    t.integer  "district_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "idds",            limit: 255
    t.string   "ic",              limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "wards", force: :cascade do |t|
    t.integer  "external_id",     limit: 4
    t.integer  "municipality_id", limit: 4
    t.integer  "district_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
