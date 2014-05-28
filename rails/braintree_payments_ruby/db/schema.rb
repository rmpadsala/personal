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

ActiveRecord::Schema.define(version: 20140127204813) do

  create_table "algofast_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "braintree_customer_id"
  end

  add_index "algofast_users", ["email"], name: "index_algofast_users_on_email", unique: true
  add_index "algofast_users", ["reset_password_token"], name: "index_algofast_users_on_reset_password_token", unique: true

  create_table "basket_contingencies", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "complex_contingency_id"
    t.integer  "match_operator"
  end

  create_table "complex_contingencies", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "strategy_record_id"
    t.integer  "match_operator"
  end

  create_table "contingency_infos", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "basket_contingency_id"
    t.string   "expected_value"
    t.string   "indicator_id"
    t.boolean  "is_matched"
    t.boolean  "is_released"
    t.integer  "logic"
    t.integer  "source"
    t.integer  "strategy_type"
  end

  create_table "contract_infos", force: true do |t|
    t.string   "contract"
    t.integer  "contract_type"
    t.integer  "order_info_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_infos", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_tif"
    t.integer  "order_type"
    t.float    "price"
    t.integer  "qty"
    t.string   "routing_account"
    t.integer  "side"
    t.float    "stop_px"
    t.integer  "order_list_id"
  end

  create_table "order_lists", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "strategy_record_id"
  end

  create_table "strategy_records", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "AlgofastUserId"
    t.integer  "duration"
    t.integer  "exec_platform"
    t.integer  "strategy_matrix_type"
    t.string   "submit_time"
    t.string   "record_id"
    t.integer  "state"
  end

  create_table "subscriptions", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "payment_token"
    t.integer  "algofast_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "braintree_customer_id"
    t.string   "braintree_subscription_id"
  end

end
