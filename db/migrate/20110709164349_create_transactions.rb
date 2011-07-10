class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.date       :dated_on,       null: false
      t.string     :description,    null: false
      t.integer    :position,       null: false
      t.references :debit_account,  null: false
      t.references :credit_account, null: false
      t.references :worksheet,      null: false
      t.decimal    :amount,         null: false, precision: 16, scale: 8

      t.timestamps null: false
    end

    add_index :transactions, :debit_account_id
    add_index :transactions, :credit_account_id
    add_index :transactions, :worksheet_id

    add_index :transactions, [:worksheet_id, :position], unique: true
  end
end
