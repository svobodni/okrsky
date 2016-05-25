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

ActiveRecord::Schema.define(version: 20160524221313) do

  create_table "commisaries", force: :cascade do |t|
    t.string   "name"
    t.string   "birth_number"
    t.string   "address"
    t.string   "postal_address"
    t.string   "phone"
    t.string   "email"
    t.integer  "town_hall_id"
    t.string   "ward_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ward_id"
  end

  create_table "districts", force: :cascade do |t|
    t.string   "name"
    t.integer  "municipality_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "municipalities", force: :cascade do |t|
    t.string   "name"
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "registration_allowed"
  end

  create_table "rails_admin_histories", force: :cascade do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 5
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories"

  create_table "regions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password"
    t.string   "chairman_email"
    t.string   "assignee_name"
    t.datetime "registration_ends_at"
  end

  create_table "town_halls", force: :cascade do |t|
    t.string   "type"
    t.string   "name"
    t.string   "address"
    t.integer  "wards_count"
    t.string   "wards_list_uri"
    t.integer  "municipality_id"
    t.integer  "district_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "idds"
    t.string   "ic"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "wards", force: :cascade do |t|
    t.integer  "external_id"
    t.integer  "municipality_id"
    t.integer  "district_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
