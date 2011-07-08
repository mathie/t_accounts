class CreateWorksheets < ActiveRecord::Migration
  def change
    create_table :worksheets do |t|
      t.string :name,    :null => false
      t.text :narrative, :null => false

      t.timestamps :null => false
    end
  end
end
