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

ActiveRecord::Schema.define(version: 20170510153337) do

  create_table "clients", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "company"
    t.string "phone"
    t.string "email"
    t.string "address"
  end

  create_table "drivers", force: :cascade do |t|
    t.string  "name"
    t.integer "age"
    t.integer "experience"
    t.string  "phone"
    t.string  "email"
    t.string  "address"
    t.string  "lic_state"
    t.integer "lic_number"
    t.string  "lic_class"
  end

  create_table "trips", force: :cascade do |t|
    t.integer  "driver_id"
    t.integer  "vehicle_id"
    t.integer  "client_id"
    t.float    "price"
    t.integer  "miles"
    t.integer  "num_of_pass"
    t.datetime "pickup_time"
    t.string   "pickup_loc"
    t.datetime "dropoff_time"
    t.string   "dropoff_loc"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "estimated_time_minutes"
    t.index ["client_id"], name: "index_trips_on_client_id"
    t.index ["driver_id"], name: "index_trips_on_driver_id"
    t.index ["vehicle_id"], name: "index_trips_on_vehicle_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string  "lic_plate"
    t.integer "year"
    t.string  "make"
    t.string  "model"
    t.string  "color"
    t.integer "seats"
    t.integer "mileage"
    t.string  "type"
    t.string  "veh_class"
  end

end
