class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.text :content, limit: 4294967295
      t.text :excerpt
      t.string :title
      t.string :status
      t.timestamps
    end
    add_index :posts, :title
    add_index :posts, :status
  end
end
