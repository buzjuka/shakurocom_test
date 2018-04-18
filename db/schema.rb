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

ActiveRecord::Schema.define(version: 20180415183708) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "balance_transactions", force: :cascade do |t|
    t.integer  "transaction_type",     default: 0, null: false
    t.integer  "amount",                           null: false
    t.integer  "book_shop_balance_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["book_shop_balance_id"], name: "index_balance_transactions_on_book_shop_balance_id", using: :btree
  end

  create_table "book_shop_balances", force: :cascade do |t|
    t.bigint   "sold_count",  default: 0, null: false
    t.bigint   "stock_count", default: 0, null: false
    t.integer  "book_id"
    t.integer  "shop_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["book_id"], name: "index_book_shop_balances_on_book_id", using: :btree
    t.index ["shop_id"], name: "index_book_shop_balances_on_shop_id", using: :btree
  end

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.integer  "publisher_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["publisher_id"], name: "index_books_on_publisher_id", using: :btree
  end

  create_table "publishers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.uuid     "access_token", default: -> { "uuid_generate_v4()" }, null: false
  end

  create_table "shops", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.uuid     "access_token", default: -> { "uuid_generate_v4()" }, null: false
  end

  add_foreign_key "balance_transactions", "book_shop_balances"
  add_foreign_key "book_shop_balances", "books"
  add_foreign_key "book_shop_balances", "shops"
  add_foreign_key "books", "publishers"
end
