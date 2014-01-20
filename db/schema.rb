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

ActiveRecord::Schema.define(version: 20140119215914) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: true do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "alias"
  end

  add_index "companies", ["alias"], name: "index_companies_on_alias", using: :btree
  add_index "companies", ["name", "country_id"], name: "index_companies_on_name_and_country_id", unique: true, using: :btree

  create_table "countries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "alias"
  end

  add_index "countries", ["alias"], name: "index_countries_on_alias", using: :btree
  add_index "countries", ["name"], name: "index_countries_on_name", unique: true, using: :btree

  create_table "doses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "doses", ["name"], name: "index_doses_on_name", unique: true, using: :btree

  create_table "drugstores", force: true do |t|
    t.integer  "external_id"
    t.string   "name"
    t.string   "address"
    t.string   "working_hours"
    t.string   "phone"
    t.datetime "data_last_update"
    t.integer  "product_num"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "drugstores", ["external_id"], name: "index_drugstores_on_external_id", using: :btree

  create_table "ds_products", force: true do |t|
    t.integer  "external_id"
    t.integer  "product_id"
    t.string   "full_name"
    t.float    "max_price"
    t.float    "min_price"
    t.float    "avg_price"
    t.integer  "drugstore_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ds_products", ["external_id"], name: "index_ds_products_on_external_id", using: :btree
  add_index "ds_products", ["product_id"], name: "index_ds_products_on_product_id", using: :btree

  create_table "forms", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "forms", ["name"], name: "index_forms_on_name", unique: true, using: :btree

  create_table "group_types", force: true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "alias"
  end

  add_index "group_types", ["alias"], name: "index_group_types_on_alias", using: :btree
  add_index "group_types", ["name"], name: "index_group_types_on_name", unique: true, using: :btree

  create_table "inns", force: true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "alias"
  end

  add_index "inns", ["alias"], name: "index_inns_on_alias", using: :btree
  add_index "inns", ["name"], name: "index_inns_on_name", unique: true, using: :btree

  create_table "packs", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "packs", ["name"], name: "index_packs_on_name", unique: true, using: :btree

  create_table "product_groups", force: true do |t|
    t.text     "name"
    t.string   "category"
    t.integer  "type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "alias"
  end

  add_index "product_groups", ["alias"], name: "index_product_groups_on_alias", using: :btree
  add_index "product_groups", ["name", "category", "type_id"], name: "index_product_groups_on_name_and_category_and_type_id", unique: true, using: :btree

  create_table "product_prices", force: true do |t|
    t.integer  "ds_product_id"
    t.integer  "drugstore_id"
    t.integer  "external_id"
    t.text     "full_name"
    t.float    "price"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.integer  "rls_code"
    t.integer  "product_group_id"
    t.integer  "inn_id"
    t.integer  "form_id"
    t.integer  "dose_id"
    t.integer  "pack_id"
    t.integer  "company_id"
    t.integer  "ean",              limit: 8
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
  add_index "products", ["rls_code"], name: "index_products_on_rls_code", using: :btree

  create_table "rls_products", force: true do |t|
    t.integer  "code"
    t.text     "name"
    t.string   "category"
    t.text     "product_group_type"
    t.string   "product_form"
    t.string   "dose"
    t.string   "pack"
    t.string   "company"
    t.string   "country"
    t.text     "inn"
    t.integer  "ean",                limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rls_products", ["code"], name: "index_rls_products_on_code", unique: true, using: :btree

  create_table "scores", force: true do |t|
    t.integer  "product_id"
    t.integer  "ds_product_id"
    t.float    "form_score"
    t.float    "dose_score"
    t.float    "pack_score"
    t.float    "country_score"
    t.float    "company_score"
    t.float    "full_score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scores", ["company_score"], name: "index_scores_on_company_score", using: :btree
  add_index "scores", ["country_score"], name: "index_scores_on_country_score", using: :btree
  add_index "scores", ["dose_score"], name: "index_scores_on_dose_score", using: :btree
  add_index "scores", ["form_score"], name: "index_scores_on_form_score", using: :btree
  add_index "scores", ["full_score"], name: "index_scores_on_full_score", using: :btree
  add_index "scores", ["pack_score"], name: "index_scores_on_pack_score", using: :btree
  add_index "scores", ["product_id", "ds_product_id"], name: "index_scores_on_product_id_and_ds_product_id", unique: true, using: :btree

end
