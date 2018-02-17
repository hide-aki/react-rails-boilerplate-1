class CreateRolesUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :roles_users, id: false do |t|
      t.integer :user_id, null: false
      t.integer :role_id, null: false
    end
    add_index :roles_users, :user_id
    add_index :roles_users, :role_id
  end
end
