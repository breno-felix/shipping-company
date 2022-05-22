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

ActiveRecord::Schema[7.0].define(version: 2022_05_22_151930) do
  create_table "carriers", force: :cascade do |t|
    t.string "brand_name"
    t.string "corporate_name"
    t.string "email_domain"
    t.string "registration_number"
    t.string "full_address"
    t.string "city"
    t.string "state"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deadlines", force: :cascade do |t|
    t.integer "initial_kilometer", default: 0
    t.integer "final_kilometer"
    t.integer "deadline"
    t.integer "carrier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carrier_id"], name: "index_deadlines_on_carrier_id"
  end

  create_table "kilometers", force: :cascade do |t|
    t.integer "initial_kilometer", default: 0
    t.integer "final_kilometer"
    t.integer "price_km"
    t.integer "carrier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carrier_id"], name: "index_kilometers_on_carrier_id"
  end

  create_table "price_volumes", force: :cascade do |t|
    t.integer "initial_volume", default: 0
    t.integer "final_volume"
    t.integer "price"
    t.integer "carrier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carrier_id"], name: "index_price_volumes_on_carrier_id"
  end

  create_table "prices", force: :cascade do |t|
    t.integer "initial_volume", default: 0
    t.integer "final_volume"
    t.integer "initial_weight", default: 0
    t.integer "final_weight"
    t.integer "price_km"
    t.integer "carrier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carrier_id"], name: "index_prices_on_carrier_id"
  end

  create_table "volumes", force: :cascade do |t|
    t.integer "initial_volume", default: 0
    t.integer "final_volume"
    t.integer "price_km"
    t.integer "carrier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carrier_id"], name: "index_volumes_on_carrier_id"
  end

  create_table "weights", force: :cascade do |t|
    t.integer "initial_weight"
    t.integer "final_weight"
    t.integer "price_km"
    t.integer "carrier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carrier_id"], name: "index_weights_on_carrier_id"
  end

  add_foreign_key "deadlines", "carriers"
  add_foreign_key "kilometers", "carriers"
  add_foreign_key "price_volumes", "carriers"
  add_foreign_key "prices", "carriers"
  add_foreign_key "volumes", "carriers"
  add_foreign_key "weights", "carriers"
end
