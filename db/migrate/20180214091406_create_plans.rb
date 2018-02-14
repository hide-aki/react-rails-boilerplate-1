class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
      t.string :name, null: false
      t.float :cost, default: 0, null: false
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
