class AddBioAndFullnameColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bio, :text
    add_column :users, :fullname, :string
  end
end
