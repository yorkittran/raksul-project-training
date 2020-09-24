class AddRoleAndFullnameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :role, :string, null: false, default: 'user'
    add_column :users, :fullname, :string, null: false
  end
end
