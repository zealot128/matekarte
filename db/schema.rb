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

ActiveRecord::Schema.define(version: 20150510104800) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dealers", force: :cascade do |t|
    t.string   "old_id"
    t.string   "name"
    t.string   "www"
    t.float    "lat"
    t.float    "lon"
    t.string   "country"
    t.string   "address"
    t.string   "zip"
    t.string   "phone"
    t.string   "city"
    t.text     "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "drink_offers", force: :cascade do |t|
    t.integer  "dealer_id"
    t.integer  "drink_id"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "drink_offers", ["dealer_id"], name: "index_drink_offers_on_dealer_id", using: :btree
  add_index "drink_offers", ["drink_id"], name: "index_drink_offers_on_drink_id", using: :btree

  create_table "drinks", force: :cascade do |t|
    t.string   "name"
    t.string   "www"
    t.string   "old_id"
    t.string   "review"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "drink_offers", "dealers"
  add_foreign_key "drink_offers", "drinks"
end
