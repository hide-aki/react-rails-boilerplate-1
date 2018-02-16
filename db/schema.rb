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

ActiveRecord::Schema.define(version: 20180214160958) do

  create_table "consignments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "merchant_id"
    t.integer "plan_id"
    t.integer "current_hub_id"
    t.integer "target_hub_id"
    t.integer "rider"
    t.integer "assigned_by"
    t.integer "data_entry_by"
    t.integer "completed_by"
    t.string "tracking_code", null: false
    t.string "receiver_name", null: false
    t.string "receiver_phone", null: false
    t.text "receiver_addr", null: false
    t.decimal "amount", precision: 8, scale: 2, default: "0.0", null: false
    t.float "weight", limit: 24
    t.decimal "charge", precision: 8, scale: 2, default: "0.0", null: false
    t.decimal "additional_cost", precision: 8, scale: 2, default: "0.0", null: false
    t.decimal "compensation", precision: 8, scale: 2, default: "0.0", null: false
    t.integer "payment_status", default: 0, null: false
    t.string "merchant_order_no"
    t.string "package_description"
    t.datetime "delivered_on"
    t.datetime "assigned_on"
    t.datetime "completed_on"
    t.datetime "data_entry_on"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["merchant_id"], name: "index_consignments_on_merchant_id"
    t.index ["rider"], name: "index_consignments_on_rider"
    t.index ["tracking_code"], name: "index_consignments_on_tracking_id", unique: true
  end

  create_table "hubs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.integer "created_by"
    t.integer "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_hubs_on_name", unique: true
  end

  create_table "merchants", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.integer "hub_id"
    t.string "name"
    t.string "business_owner"
    t.string "representative_name"
    t.string "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_merchants_on_name", unique: true
  end

  create_table "plans", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.decimal "cost", precision: 8, scale: 2, default: "0.0", null: false
    t.integer "created_by"
    t.integer "updated_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_plans_on_name", unique: true
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_roles_on_title", unique: true
  end

  create_table "roles_users", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id", null: false
    t.integer "role_id", null: false
    t.index ["role_id"], name: "index_roles_users_on_role_id"
    t.index ["user_id"], name: "index_roles_users_on_user_id"
  end

  create_table "students", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.integer "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "first_name"
    t.string "last_name"
    t.integer "gender"
    t.datetime "dob"
    t.string "phone_number"
    t.string "profile_picture"
    t.integer "status", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
