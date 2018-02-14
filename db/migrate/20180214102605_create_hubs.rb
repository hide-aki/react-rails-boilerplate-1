class CreateHubs < ActiveRecord::Migration[5.1]
  def change
    create_table :hubs do |t|
      t.string :name, null: false
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
    add_index :hubs, :name, unique: true
  end
end
