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

ActiveRecord::Schema.define(version: 20160402214304) do

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.integer  "price"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shopper_engine_addresses", force: :cascade do |t|
    t.string   "phone"
    t.string   "address"
    t.string   "zipcode"
    t.string   "city"
    t.integer  "country_id"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shopper_engine_countries", force: :cascade do |t|
    t.string   "name"
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shopper_engine_credit_cards", force: :cascade do |t|
    t.string   "number"
    t.string   "cvv"
    t.integer  "expiration_month"
    t.integer  "expiration_year"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shopper_engine_deliveries", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shopper_engine_order_items", force: :cascade do |t|
    t.integer  "price"
    t.integer  "quantity"
    t.integer  "product_id"
    t.string   "product_type"
    t.integer  "book_id"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shopper_engine_orders", force: :cascade do |t|
    t.integer  "price",               default: 0
    t.date     "completed_date"
    t.integer  "state"
    t.integer  "shipping_address_id"
    t.integer  "billing_address_id"
    t.integer  "customer_id"
    t.integer  "credit_card_id"
    t.integer  "delivery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
