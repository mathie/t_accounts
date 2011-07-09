class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string     :name,      null: false
      t.string     :code,      null: false, limit: 3
      t.references :worksheet, null: false

      t.timestamps null: false
    end

    add_index :accounts, [:worksheet_id, :name], :unique => true
    add_index :accounts, [:worksheet_id, :code], :unique => true
  end
end
