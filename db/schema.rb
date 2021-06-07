# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_25_113631) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bootstrap_configurations", force: :cascade do |t|
    t.string "version"
    t.json "store_required_colours"
    t.json "store_optional_colours"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "font_size_base", precision: 10, scale: 6, default: "1.0"
    t.json "font_family_sans_serif"
    t.json "font_family_monospace"
    t.string "body_bg", default: "#ffffff"
    t.string "body_color", default: "#212529"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.text "body", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
