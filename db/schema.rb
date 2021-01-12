# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_12_174552) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "client_id"
    t.string "reference"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "days_count"
    t.boolean "dates_filter", default: false
    t.boolean "kind_filter", default: false
    t.string "button_text"
    t.integer "position"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "api_key"
    t.hstore "preferences"
    t.json "invoicing_fields"
    t.string "webhook"
    t.string "webhook_api_key"
    t.string "currency"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "order_title"
    t.string "order_description"
    t.string "order_checkout_text"
    t.string "order_checkout_button"
    t.string "webhook_url"
    t.string "order_cart_title"
    t.string "order_address_title"
    t.string "catalog_type"
    t.string "date_select_choose_text"
    t.string "basic_auth_username"
    t.string "basic_auth_password"
    t.string "catch_phrase"
    t.string "order_thank_you_text"
    t.string "subdomain"
    t.string "order_thank_you_title"
    t.json "delivery_fields"
    t.string "order_delivery_title"
    t.string "catalog_title"
    t.json "delivery_fields_values"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "product_id"
    t.string "title"
    t.text "description"
    t.json "order_fields"
    t.json "order_fields_values"
    t.integer "order_id"
    t.float "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "product_reference"
    t.date "start_date"
  end

  create_table "orders", force: :cascade do |t|
    t.string "number"
    t.string "reference"
    t.string "key"
    t.float "total"
    t.integer "client_id"
    t.string "currency"
    t.string "status"
    t.json "invocing_fields_values"
    t.string "title"
    t.text "description"
    t.text "checkout_text"
    t.text "checkout_button"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "cart_title"
    t.string "address_title"
    t.string "thank_you_text"
    t.string "thank_you_title"
    t.string "delivery_title"
    t.date "start_date"
  end

  create_table "prices", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.float "price"
    t.integer "product_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "status"
    t.boolean "display"
    t.date "start_date"
    t.date "end_date"
    t.json "order_fields"
    t.string "reference"
    t.string "category_reference"
    t.integer "client_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "kind"
    t.string "button_prefix_text"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
