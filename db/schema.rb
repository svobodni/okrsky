# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_28_221021) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "commisaries", force: :cascade do |t|
    t.string "name"
    t.string "birth_number"
    t.string "address"
    t.string "postal_address"
    t.string "phone"
    t.string "email"
    t.integer "town_hall_id"
    t.string "ward_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "ward_id"
    t.string "encrypted_password"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "user_id"
  end

  create_table "districts", force: :cascade do |t|
    t.string "name"
    t.integer "municipality_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: :cascade do |t|
    t.string "uuid"
    t.string "name"
    t.string "requestor_type"
    t.integer "requestor_id"
    t.string "eventable_type"
    t.integer "eventable_id"
    t.string "command"
    t.text "metadata"
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "municipalities", force: :cascade do |t|
    t.string "name"
    t.integer "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "registration_allowed"
  end

  create_table "rails_admin_histories", force: :cascade do |t|
    t.text "message"
    t.string "username"
    t.integer "item"
    t.string "table"
    t.integer "month", limit: 2
    t.integer "year", limit: 5
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["item", "table", "month", "year"], name: "index_rails_admin_histories"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "password"
    t.string "chairman_email"
    t.string "assignee_name"
    t.datetime "registration_ends_at"
    t.integer "representative_id"
  end

  create_table "town_halls", force: :cascade do |t|
    t.string "type"
    t.string "name"
    t.string "address"
    t.integer "wards_count"
    t.string "wards_list_uri"
    t.integer "municipality_id"
    t.integer "district_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "idds"
    t.string "ic"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wards", force: :cascade do |t|
    t.integer "external_id"
    t.integer "municipality_id"
    t.integer "district_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
