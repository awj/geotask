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

ActiveRecord::Schema.define(version: 20170921022513) do

  create_table "projects", force: :cascade do |t|
    t.string "name", null: false
    t.string "permalink", null: false
    t.string "description"
    t.decimal "north", null: false
    t.decimal "south", null: false
    t.decimal "east", null: false
    t.decimal "west", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["east"], name: "index_projects_on_east"
    t.index ["north"], name: "index_projects_on_north"
    t.index ["permalink"], name: "index_projects_on_permalink"
    t.index ["south"], name: "index_projects_on_south"
    t.index ["west"], name: "index_projects_on_west"
  end

end
