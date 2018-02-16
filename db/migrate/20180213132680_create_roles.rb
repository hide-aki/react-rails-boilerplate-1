class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.string :title, null: false

      t.timestamps
    end
    add_index :roles, :title, unique: true
  end
end
