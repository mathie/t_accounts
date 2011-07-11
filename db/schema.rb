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

ActiveRecord::Schema.define(:version => 20110711072737) do

  create_table "accounts", :force => true do |t|
    t.string   "name",                      :null => false
    t.string   "code",         :limit => 3, :null => false
    t.integer  "worksheet_id",              :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "accounts", ["worksheet_id", "code"], :name => "index_accounts_on_worksheet_id_and_code", :unique => true
  add_index "accounts", ["worksheet_id", "name"], :name => "index_accounts_on_worksheet_id_and_name", :unique => true

  create_table "transactions", :force => true do |t|
    t.date     "dated_on",                                         :null => false
    t.string   "description",                                      :null => false
    t.integer  "position",                                         :null => false
    t.integer  "debit_account_id",                                 :null => false
    t.integer  "credit_account_id",                                :null => false
    t.integer  "worksheet_id",                                     :null => false
    t.decimal  "amount",            :precision => 16, :scale => 8, :null => false
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  add_index "transactions", ["credit_account_id"], :name => "index_transactions_on_credit_account_id"
  add_index "transactions", ["debit_account_id"], :name => "index_transactions_on_debit_account_id"
  add_index "transactions", ["worksheet_id", "position"], :name => "index_transactions_on_worksheet_id_and_position", :unique => true
  add_index "transactions", ["worksheet_id"], :name => "index_transactions_on_worksheet_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
    t.string   "name",                                                  :null => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "worksheets", :force => true do |t|
    t.string   "name",       :null => false
    t.text     "narrative",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id",    :null => false
  end

  add_index "worksheets", ["user_id"], :name => "index_worksheets_on_user_id"

end
