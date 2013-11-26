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

ActiveRecord::Schema.define(version: 20131126195320) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: true do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "counties", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  add_index "drug_stores", ["external_id"], name: "index_drug_stores_on_external_id", using: :btree

  create_table "ds_products", force: true do |t|
    t.integer  "external_id"
    t.string   "full_name"
    t.integer  "rls_code"
    t.float    "ave_price"
    t.string   "ean"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ds_products", ["ean"], name: "index_ds_products_on_ean", using: :btree
  add_index "ds_products", ["external_id"], name: "index_ds_products_on_external_id", using: :btree
  add_index "ds_products", ["rls_code"], name: "index_ds_products_on_rls_code", using: :btree

  create_table "forms", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inns", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "packs", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_groups", force: true do |t|
    t.string   "name"
    t.string   "category"
    t.integer  "type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  add_index "product_prices", ["ean"], name: "index_product_prices_on_ean", using: :btree
  add_index "product_prices", ["external_id"], name: "index_product_prices_on_external_id", using: :btree
  add_index "product_prices", ["full_name"], name: "index_product_prices_on_full_name", using: :btree
  add_index "product_prices", ["product_id", "drugstore_id"], name: "index_product_prices_on_product_id_and_drugstore_id", unique: true, using: :btree

  create_table "products", force: true do |t|
    t.integer  "rls_code"
    t.integer  "product_group_id"
    t.integer  "inn_id"
    t.integer  "form_id"
    t.integer  "dose_id"
    t.integer  "pack_id"
    t.integer  "company_id"
    t.string   "ean"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["company_id"], name: "index_products_on_company_id", using: :btree
  add_index "products", ["dose_id"], name: "index_products_on_dose_id", using: :btree
  add_index "products", ["ean"], name: "index_products_on_ean", using: :btree
  add_index "products", ["form_id"], name: "index_products_on_form_id", using: :btree
  add_index "products", ["inn_id"], name: "index_products_on_inn_id", using: :btree
  add_index "products", ["pack_id"], name: "index_products_on_pack_id", using: :btree
  add_index "products", ["product_group_id"], name: "index_products_on_product_group_id", using: :btree

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
    t.text     "inn"
    t.string   "ean"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rls_products", ["code"], name: "index_rls_products_on_code", unique: true, using: :btree

end
