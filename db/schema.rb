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

ActiveRecord::Schema.define(version: 20170429145542) do

  create_table "names", force: :cascade do |t|
    t.string   "name"
    t.integer  "wiki_id"
    t.integer  "changed_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_names_on_name", unique: true
  end

  create_table "page_names", force: :cascade do |t|
    t.integer  "page_id"
    t.integer  "name_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id", "name_id"], name: "index_page_names_on_page_id_and_name_id", unique: true
  end

  create_table "pages", force: :cascade do |t|
    t.string   "content"
    t.integer  "wiki_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wikis", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
