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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120126002720) do

  create_table "budgets", :force => true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "envelopes", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.decimal  "budget_percent"
    t.integer  "budget_id"
  end

  create_table "goals", :force => true do |t|
    t.string   "name"
    t.date     "deadline"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "submits", :force => true do |t|
    t.datetime "time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
  end

  create_table "transactions", :force => true do |t|
    t.date     "date"
    t.string   "vendor"
    t.text     "desc"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "envelope_id"
    t.integer  "goal_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                       :null => false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
  end

  add_index "users", ["activation_token"], :name => "index_users_on_activation_token"

end
