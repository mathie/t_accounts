class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.database_authenticatable null: false
      t.recoverable
      t.rememberable
      t.trackable
      t.confirmable

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true

    add_column :worksheets, :user_id, :integer, null: false
    add_index :worksheets, :user_id
  end
end
