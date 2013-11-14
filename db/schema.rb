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

ActiveRecord::Schema.define(version: 20131113203547) do

  create_table "drug_stores", force: true do |t|
    t.integer  "external_id"
    t.string   "name"
    t.string   "address"
    t.string   "working_hours"
    t.string   "sec_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone"
    t.datetime "data_last_update"
  end

  add_index "drug_stores", ["external_id"], name: "index_drug_stores_on_external_id"

  create_table "ds_products", force: true do |t|
    t.integer  "external_id"
    t.string   "full_name"
    t.integer  "rls_code"
    t.float    "ave_price"
    t.string   "ean"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ds_products", ["ean"], name: "index_ds_products_on_ean"
  add_index "ds_products", ["external_id"], name: "index_ds_products_on_external_id"
  add_index "ds_products", ["rls_code"], name: "index_ds_products_on_rls_code"

  create_table "product_prices", force: true do |t|
    t.integer  "product_id"
    t.integer  "drugstore_id"
    t.integer  "external_id"
    t.float    "price"
    t.integer  "amount"
    t.string   "full_name"
    t.string   "ean"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "delete_flag",  default: false
  end

  add_index "product_prices", ["ean"], name: "index_product_prices_on_ean"
  add_index "product_prices", ["external_id"], name: "index_product_prices_on_external_id"
  add_index "product_prices", ["full_name"], name: "index_product_prices_on_full_name"
  add_index "product_prices", ["product_id", "drugstore_id"], name: "index_product_prices_on_product_id_and_drugstore_id", unique: true

  create_table "rls_products", force: true do |t|
    t.integer  "code"
    t.string   "name"
    t.string   "category"
    t.string   "product_type"
    t.string   "product_form"
    t.string   "dose"
    t.string   "pack"
    t.string   "company"
    t.string   "country"
    t.string   "inn"
    t.string   "ean"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rls_products", ["code"], name: "index_rls_products_on_code", unique: true

end
