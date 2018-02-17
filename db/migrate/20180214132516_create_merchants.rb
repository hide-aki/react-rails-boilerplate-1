class CreateMerchants < ActiveRecord::Migration[5.1]
  def change
    create_table :merchants do |t|
      t.integer :user_id
      t.integer :hub_id
      t.string :name
      t.string :business_owner
      t.string :representative_name
      t.string :website
      # t.integer :created_by
      # t.integer :updated_by

      t.timestamps
    end
    add_index :merchants, :name, unique: true
  end
end
