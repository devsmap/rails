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

ActiveRecord::Schema.define(version: 2021_08_06_175312) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "parent_id"
    t.string "icon"
    t.boolean "is_active", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
    t.index ["parent_id"], name: "index_categories_on_parent_id"
  end

  create_table "cities", force: :cascade do |t|
    t.bigint "state_id", null: false
    t.string "name", null: false
    t.boolean "is_active", default: true
    t.string "latitude", null: false
    t.string "longitude", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_cities_on_name"
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "is_active", default: false
    t.string "region", null: false
    t.string "subregion", null: false
    t.string "latitude", null: false
    t.string "longitude", null: false
    t.string "emoji", null: false
    t.string "google_uule", null: false
    t.string "google_hl", null: false
    t.string "google_gl", null: false
    t.string "time_zone", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_countries_on_name", unique: true
  end

  create_table "google", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "state_id", null: false
    t.boolean "is_detailed", default: false
    t.string "job_id"
    t.string "title"
    t.string "company"
    t.string "city"
    t.string "via"
    t.string "published_at"
    t.text "description"
    t.string "link"
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.string "deleted_reason"
    t.index ["category_id"], name: "index_google_on_category_id"
    t.index ["job_id"], name: "index_google_on_job_id", unique: true
    t.index ["state_id"], name: "index_google_on_state_id"
  end

  create_table "jobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "city_id", null: false
    t.boolean "is_active", default: false
    t.string "title"
    t.string "company"
    t.text "description"
    t.string "via"
    t.string "link"
    t.datetime "published_at"
    t.string "time_zone"
    t.string "gogole_job_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.string "deleted_reason"
    t.index ["category_id"], name: "index_jobs_on_category_id"
    t.index ["city_id"], name: "index_jobs_on_city_id"
    t.index ["gogole_job_id"], name: "index_jobs_on_gogole_job_id", unique: true
  end

  create_table "states", force: :cascade do |t|
    t.bigint "country_id", null: false
    t.string "name", null: false
    t.string "state_code", null: false
    t.boolean "is_active", default: false
    t.string "latitude", null: false
    t.string "longitude", null: false
    t.string "google_uule", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_id"], name: "index_states_on_country_id"
    t.index ["name"], name: "index_states_on_name", unique: true
  end

  add_foreign_key "categories", "categories", column: "parent_id", on_delete: :cascade
  add_foreign_key "cities", "states"
  add_foreign_key "google", "categories"
  add_foreign_key "google", "states"
  add_foreign_key "jobs", "categories"
  add_foreign_key "jobs", "cities"
  add_foreign_key "states", "countries"
end
