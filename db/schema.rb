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

ActiveRecord::Schema[8.0].define(version: 2025_03_05_195100) do
  create_table "alt_spellings", force: :cascade do |t|
    t.integer "country_id", null: false
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_alt_spellings_on_country_id"
  end

  create_table "capital_infos", force: :cascade do |t|
    t.integer "country_id", null: false
    t.float "lat"
    t.float "lng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_capital_infos_on_country_id"
  end

  create_table "capitals", force: :cascade do |t|
    t.integer "country_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_capitals_on_country_id"
  end

  create_table "cars", force: :cascade do |t|
    t.integer "country_id", null: false
    t.string "side"
    t.json "signs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_cars_on_country_id"
  end

  create_table "coat_of_arms", force: :cascade do |t|
    t.integer "country_id", null: false
    t.string "png"
    t.string "svg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_coat_of_arms_on_country_id"
  end

  create_table "continents", force: :cascade do |t|
    t.integer "country_id", null: false
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_continents_on_country_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "cca2"
    t.string "ccn3"
    t.string "cca3"
    t.boolean "independent"
    t.string "status"
    t.boolean "un_member"
    t.string "region"
    t.boolean "landlocked"
    t.float "area"
    t.integer "population"
    t.string "start_of_week"
    t.string "flag"
    t.float "lat"
    t.float "lng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "country_flags", force: :cascade do |t|
    t.integer "country_id", null: false
    t.string "png"
    t.string "svg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_country_flags_on_country_id"
  end

  create_table "country_maps", force: :cascade do |t|
    t.integer "country_id", null: false
    t.string "google_maps"
    t.string "open_street_maps"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_country_maps_on_country_id"
  end

  create_table "country_names", force: :cascade do |t|
    t.integer "country_id", null: false
    t.string "common"
    t.string "official"
    t.json "native_names"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_country_names_on_country_id"
  end

  create_table "currencies", force: :cascade do |t|
    t.integer "country_id", null: false
    t.string "code"
    t.string "name"
    t.string "symbol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_currencies_on_country_id"
  end

  create_table "demonyms", force: :cascade do |t|
    t.integer "country_id", null: false
    t.string "language_code"
    t.string "female"
    t.string "male"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_demonyms_on_country_id"
  end

  create_table "games", force: :cascade do |t|
    t.json "payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "idds", force: :cascade do |t|
    t.integer "country_id", null: false
    t.string "root"
    t.json "suffixes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_idds_on_country_id"
  end

  create_table "languages", force: :cascade do |t|
    t.integer "country_id", null: false
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_languages_on_country_id"
  end

  create_table "timezones", force: :cascade do |t|
    t.integer "country_id", null: false
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_timezones_on_country_id"
  end

  create_table "tlds", force: :cascade do |t|
    t.integer "country_id", null: false
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_tlds_on_country_id"
  end

  create_table "translations", force: :cascade do |t|
    t.integer "country_id", null: false
    t.string "language_code"
    t.string "official"
    t.string "common"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_translations_on_country_id"
  end

  add_foreign_key "alt_spellings", "countries"
  add_foreign_key "capital_infos", "countries"
  add_foreign_key "capitals", "countries"
  add_foreign_key "cars", "countries"
  add_foreign_key "coat_of_arms", "countries"
  add_foreign_key "continents", "countries"
  add_foreign_key "country_flags", "countries"
  add_foreign_key "country_maps", "countries"
  add_foreign_key "country_names", "countries"
  add_foreign_key "currencies", "countries"
  add_foreign_key "demonyms", "countries"
  add_foreign_key "idds", "countries"
  add_foreign_key "languages", "countries"
  add_foreign_key "timezones", "countries"
  add_foreign_key "tlds", "countries"
  add_foreign_key "translations", "countries"
end
