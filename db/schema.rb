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

ActiveRecord::Schema.define(version: 20160704201639) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "causes", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "tagline"
    t.string "description"
  end

  create_table "causes_charities", id: false, force: :cascade do |t|
    t.integer "cause_id",   null: false
    t.integer "charity_id", null: false
  end

  create_table "charities", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "charity_photo_file_name"
    t.string   "charity_photo_content_type"
    t.integer  "charity_photo_file_size"
    t.datetime "charity_photo_updated_at"
    t.string   "slug"
    t.integer  "status_id",                  default: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tagline"
  end

  add_index "charities", ["status_id"], name: "index_charities_on_status_id", using: :btree

  create_table "donation_items", force: :cascade do |t|
    t.integer  "quantity"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "donation_id"
    t.integer  "need_item_id"
  end

  add_index "donation_items", ["donation_id"], name: "index_donation_items_on_donation_id", using: :btree
  add_index "donation_items", ["need_item_id"], name: "index_donation_items_on_need_item_id", using: :btree

  create_table "donations", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "donations", ["user_id"], name: "index_donations_on_user_id", using: :btree

  create_table "need_items", force: :cascade do |t|
    t.integer  "quantity"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "recipient_id"
    t.datetime "deadline"
    t.integer  "need_id"
  end

  add_index "need_items", ["need_id"], name: "index_need_items_on_need_id", using: :btree
  add_index "need_items", ["recipient_id"], name: "index_need_items_on_recipient_id", using: :btree

  create_table "needs", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.decimal  "price"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.datetime "date"
    t.integer  "needs_category_id"
    t.integer  "charity_id"
    t.integer  "status_id",         default: 1
  end

  add_index "needs", ["charity_id"], name: "index_needs_on_charity_id", using: :btree
  add_index "needs", ["needs_category_id"], name: "index_needs_on_needs_category_id", using: :btree
  add_index "needs", ["status_id"], name: "index_needs_on_status_id", using: :btree

  create_table "needs_categories", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "tagline"
    t.string "description"
  end

  create_table "recipients", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "description"
    t.string   "recipient_photo_file_name"
    t.string   "recipient_photo_content_type"
    t.integer  "recipient_photo_file_size"
    t.datetime "recipient_photo_updated_at"
    t.integer  "charity_id"
  end

  add_index "recipients", ["charity_id"], name: "index_recipients_on_charity_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "charity_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_roles", ["charity_id"], name: "index_user_roles_on_charity_id", using: :btree
  add_index "user_roles", ["role_id"], name: "index_user_roles_on_role_id", using: :btree
  add_index "user_roles", ["user_id"], name: "index_user_roles_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "email"
  end

  add_foreign_key "charities", "statuses"
  add_foreign_key "donation_items", "donations"
  add_foreign_key "donation_items", "need_items"
  add_foreign_key "donations", "users"
  add_foreign_key "need_items", "needs"
  add_foreign_key "need_items", "recipients"
  add_foreign_key "needs", "charities"
  add_foreign_key "needs", "needs_categories"
  add_foreign_key "needs", "statuses"
  add_foreign_key "recipients", "charities"
  add_foreign_key "user_roles", "charities"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
end
