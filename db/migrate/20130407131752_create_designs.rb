class CreateDesigns < ActiveRecord::Migration
  def change
    create_table :designs do |t|
      t.integer :user_id
      t.text :html
      t.text :css
      t.timestamps
    end
    add_index :designs, :user_id
  end
end
