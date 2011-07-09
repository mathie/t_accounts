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

ActiveRecord::Schema.define(:version => 20110709164349) do

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

  create_table "worksheets", :force => true do |t|
    t.string   "name",       :null => false
    t.text     "narrative",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
